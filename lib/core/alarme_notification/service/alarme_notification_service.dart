import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';

import '../data/service/local/alarme_persistance_service.dart';
import '../data/service/notification_local_service.dart';
import '../domaine/entities/alarme_entite.dart';

/// Service central du module alarme/notification.
///
/// C'est la porte d'entrée unique pour :
/// - l'initialisation du système de notifications au démarrage de l'app,
/// - l'arrêt / nettoyage des ressources,
/// - le traitement des interactions utilisateur avec les notifications
///   (clic, action personnalisée, ouverture d'une page),
/// - la **re-programmation** des alarmes après extinction de l'app
///   (les alarmes ponctuelles Android ne survivent pas au reboot : elles
///   sont ré-enregistrées ici depuis [AlarmePersistanceService]).
///
/// Il n'expose AUCUNE logique d'alarme : la création / modification /
/// suppression d'alarmes passe par les usecases du domaine (voir
/// `domaine/usecase/`). Ce service se contente du cycle de vie et du routage
/// des actions.
///
/// Utilisation dans `main.dart` :
/// ```dart
/// await getIt<AlarmeNotificationService>().initialiser();
/// ```
/// Enregistré dans l'injection via `@lazySingleton` (injectable).
@lazySingleton
class AlarmeNotificationService {
  AlarmeNotificationService(
    this._notificationService,
    this._persistance,
  );

  final NotificationLocalService _notificationService;
  final AlarmePersistanceService _persistance;

  /// Handler appelé à chaque interaction utilisateur avec une notification
  /// (app en premier plan / arrière-plan). Laissé libre aux features pour
  /// naviguer (ex: via go_router) selon le payload `{'route': ..., ...}`.
  void Function(Map<String, String> payload)? onNotificationTapped;

  /// Payload de la notification qui a **lancé l'app** (cold start), ou `null`
  /// si l'app n'a pas été ouverte par une notification.
  ///
  /// Rempli pendant [initialiser] avant `_initialise = true`, donc disponible
  /// pour la navigation dès le premier frame.
  Map<String, String>? get payloadDeLancement => _payloadDeLancement;
  Map<String, String>? _payloadDeLancement;

  bool _initialise = false;

  /// Initialisation unique du module (à appeler dans `main.dart` après
  /// `configureDependencies()`).
  ///
  /// 1. enregistre les callbacks d'interaction,
  /// 2. initialise le plugin + fuseau horaire,
  /// 3. lit `getNotificationAppLaunchDetails` : si l'app a été ouverte **par**
  ///    une notification (cold start), expose le payload via
  ///    [payloadDeLancement] et appelle [onNotificationTapped],
  /// 4. **re-programme** toutes les alarmes ponctuelles encore à venir
  ///    persistées localement (nécessaire après un reboot Android).
  Future<void> initialiser() async {
    if (_initialise) return;

    _notificationService.onNotificationReponse = _gererReponse;

    await _notificationService.initialiser();

    // ── Cold start : app ouverte par une notification ? ──
    final lancement =
        await FlutterLocalNotificationsPlugin().getNotificationAppLaunchDetails();
    if (lancement != null &&
        lancement.didNotificationLaunchApp &&
        lancement.notificationResponse?.payload != null) {
      _payloadDeLancement = _decoderPayload(
        lancement.notificationResponse!.payload!,
      );
      if (_payloadDeLancement != null && _payloadDeLancement!.isNotEmpty) {
        onNotificationTapped?.call(_payloadDeLancement!);
      }
    }

    // ── Re-programmation après reboot (Android efface les alarmes ponctuelles)
    await _reprogrammerAlarmesPersistees();

    _initialise = true;
  }

  /// Nettoyage à la fermeture de l'app (ou lors d'un logout, par ex.).
  /// ⚠️ N'efface PAS la persistance : les alarmes futures doivent
  /// réapparaître à la prochaine ouverture de l'app.
  Future<void> arreter() async {
    await _notificationService.arreter();
    _initialise = false;
  }

  /// True si [initialiser] a déjà été exécuté avec succès.
  bool get estInitialise => _initialise;

  /// Re-programme les alarmes ponctuelles futures persistées.
  ///
  /// Les alarmes **répétées** n'ont pas besoin de cette étape côté OS
  /// (`matchDateTimeComponents: dayOfWeekAndTime`), mais on les re-programme
  /// volontairement aussi : c'est idempotent (mêmes ids) et ça répare tout
  /// cas où l'OS les aurait perdues.
  Future<void> _reprogrammerAlarmesPersistees() async {
    for (final alarme in _persistance.alarmesActives()) {
      try {
        await _notifierRepoInterne(alarme);
      } catch (e) {
        // Une alarme invalide (date passée, permission révoquée…) ne doit
        // jamais empêcher l'app de démarrer ni bloquer les autres alarmes.
        debugPrint('⚠️ Re-programmation impossible pour l\'alarme '
            '${alarme.id} : $e');
      }
    }
  }

  /// Réexploite directement la logique OS de programmation (mêmes appels que
  /// `AlarmeRepositoryImpl.programmer`, sans écrire la persistance à nouveau).
  Future<void> _notifierRepoInterne(AlarmeEntite alarme) async {
    final repetee = alarme.joursDeRepetition.values.any((actif) => actif);
    if (repetee) {
      await _notificationService.programmerRepetee(
        alarme.id,
        alarme.titre,
        alarme.corps,
        alarme.dateHeure,
        alarme.joursDeRepetition,
        canal: alarme.channelId,
        payload: alarme.payload,
      );
    } else {
      await _notificationService.programmer(
        alarme.id,
        alarme.titre,
        alarme.corps,
        alarme.dateHeure,
        canal: alarme.channelId,
        payload: alarme.payload,
      );
    }
  }

  // ───────────────────────────── Actions ─────────────────────────────────

  /// Appelé par le callback du plugin ; décode le payload « clé=valeur&… »
  /// et le transmet à [onNotificationTapped].
  void _gererReponse(NotificationResponse response) {
    if (onNotificationTapped == null) return;

    final payload = _decoderPayload(response.payload);
    if (payload != null && payload.isNotEmpty) {
      onNotificationTapped!(payload);
    }
  }

  static Map<String, String>? _decoderPayload(String? brut) {
    if (brut == null || brut.isEmpty) return null;
    final payload = <String, String>{};
    for (final paire in brut.split('&')) {
      final idx = paire.indexOf('=');
      if (idx > 0) {
        payload[paire.substring(0, idx)] = paire.substring(idx + 1);
      }
    }
    return payload;
  }
}
