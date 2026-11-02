import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../domaine/entities/alarme_entite.dart';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse response) {
  // Ici : pas d'accès à l'état de la classe ni à GetIt initialisé.
  // Traiter response.payload / response.actionId au besoin.
}

/// Classification de l'exception lancée par la couche data de ce module.
class NotificationServiceException implements Exception {
  const NotificationServiceException(this.message);
  final String message;
}

/// ─── Fonction TOP-LEVEL obligatoire pour le callback « background » ───
///
/// Le plugin l'invoque dans un **isolate séparé** (ex: notification affichée
/// pendant que l'app est en fond). `PluginUtilities.getCallbackHandle` ne
/// fonctionne QUE sur une fonction de premier niveau annotée
/// `@pragma('vm:entry-point')` — sinon assertion au `initialize()`.
///
/// IMPORTANT : le payload reçu ici est journalisé puis persisté dans
/// shared_preferences pour consultation à la prochaine ouverture de l'app
/// (l'isolate de fond ne peut pas toucher aux UI ni aux singletons GetIt).
@pragma('vm:entry-point')
Future<void> notificationFondCallback(NotificationResponse response) async {
  debugPrint('🔔 [fond] Notification reçue / tap: ${response.payload}');

  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(
    'core_alarme_notification.dernierPayloadFond',
    response.payload ?? '',
  );
}

/// Adaptateur technique autour de `flutter_local_notifications` et `timezone`.
///
/// Sert de "service local" pour les repositories de ce module : tous les
/// appels au plugin y sont centralisés, et ne remontent jamais vers le
/// domaine. Doit être initialisé via [initialiser] avant tout usage.
@lazySingleton
class NotificationLocalService {
  static const String _canalIdDefaut = 'core_alarme_par_defaut';
  static const String _nomCanalDefaut = 'to_doia — Notifications';

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  /// Callback déclenché quand l'utilisateur interagit avec une notification
  /// (tap, action). Renseigné par [AlarmeNotificationService].
  ///
  /// ⚠️ [onNotificationFond] DOIT rester une fonction top-level (isolate
  /// séparé) — voir @_onBackgroundNotification ci-dessous.
  DidReceiveNotificationResponseCallback? onNotificationReponse;

  /// Appelé quand une notification est reçue pendant que l'app tourne en
  /// arrière-plan (isolate de fond). Le plugin exige une fonction top-level :
  /// ce champ est ici uniquement pour la compatibilité de l'API du plugin.
  DidReceiveBackgroundNotificationResponseCallback? onNotificationFond;

  /// Initialisation unique du service (plugin + fuseau horaire).
  ///
  /// Les canaux Android sont créés automatiquement à partir des
  /// `AndroidNotificationDetails` passés à chaque notification.
  Future<void> initialiser() async {
    tz.initializeTimeZones();
    // tz.local est mis à UTC par défaut ; l'appareil fournit son vrai fuseau
    // via [DateTime.now] → on programme toujours en heure locale.
    await _plugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
          // Les permissions sont demandées explicitement par
          // PermissionNotificationRepository.
          requestCriticalPermission: false,
        ),
      ),
      onDidReceiveNotificationResponse: onNotificationReponse,
      onDidReceiveBackgroundNotificationResponse: notificationFondCallback,
    );

    await _creerCanauxAndroid();
  }

  /// Crée explicitement les canaux Android dès l'initialisation.
  ///
  /// ⚠️ Indispensable : une notification **programmée** est postée par le
  /// récepteur natif du plugin, potentiellement sans que l'app tourne. Si le
  /// canal n'existe pas encore à cet instant, Android **supprime
  /// silencieusement** la notification. On ne peut donc pas compter sur la
  /// création implicite au premier `show()`.
  Future<void> _creerCanauxAndroid() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android == null) return;

    await android.createNotificationChannel(
      const AndroidNotificationChannel(
        AppCanauxAlarme.alarme,
        'to_doia — Alarmes',
        description: 'Alarmes prioritaires (son + vibration)',
        importance: Importance.max,
        playSound: true,
        enableVibration: true,
      ),
    );
    await android.createNotificationChannel(
      const AndroidNotificationChannel(
        AppCanauxAlarme.paroisien,
        'to_doia — Notifications',
        description: 'Notifications générales de l\'application',
        importance: Importance.defaultImportance,
      ),
    );
    await android.createNotificationChannel(
      const AndroidNotificationChannel(
        AppCanauxAlarme.rappel,
        'to_doia — Rappels',
        description: 'Rappels d\'événements',
        importance: Importance.high,
        playSound: true,
        enableVibration: true,
      ),
    );
    await android.createNotificationChannel(
      const AndroidNotificationChannel(
        _canalIdDefaut,
        _nomCanalDefaut,
        description: 'Canal par défaut du module alarme/notification',
        importance: Importance.defaultImportance,
      ),
    );
  }

  // ──────────────────────────── Notifications ────────────────────────────

  /// Affiche immédiatement une notification.
  Future<void> afficher(
    int id,
    String titre,
    String corps, {
    String? canal,
    Map<String, String> payload = const <String, String>{},
  }) => _plugin.show(id, titre, corps, _details(canal), payload: _payload(payload));

  /// Programme une notification exacte à [dateHeure] (heure locale).
  Future<void> programmer(
    int id,
    String titre,
    String corps,
    DateTime dateHeure, {
    String? canal,
    Map<String, String> payload = const <String, String>{},
  }) => _plugin.zonedSchedule(
        id,
        titre,
        corps,
        _tzLocal(dateHeure),
        _details(canal),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: _payload(payload),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );

  /// alarmeProgramme : répétition hebdomadaire aux jours actifs de [jours]
  /// (1 = lundi … 7 = dimanche, convention DateTime.weekday), à l'heure de
  /// [dateHeure].
  Future<void> programmerRepetee(
    int id,
    String titre,
    String corps,
    DateTime dateHeure,
    Map<int, bool> jours, {
    String? canal,
    Map<String, String> payload = const <String, String>{},
  }) async {
    final joursActifs = jours.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toSet();

    if (joursActifs.isEmpty) {
      // Alarme ponctuelle : simple zonedSchedule à [dateHeure].
      await _plugin.zonedSchedule(
        id,
        titre,
        corps,
        _tzLocal(dateHeure),
        _details(canal),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: _payload(payload),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
      return;
    }

    // Alarme répétée : chaque jour actif est programmé avec
    // `matchDateTimeComponents: dayOfWeekAndTime` → l'OS refire la notification
    // chaque semaine au même jour/heure (mode natif, plus fiable qu'une liste
    // de dates). Ids dérivés stables id*10+jour → annulation par groupe.
    for (final jour in joursActifs) {
      final prochaine = _prochaineOccurrence(dateHeure, jour);
      await _plugin.zonedSchedule(
        id * 10 + jour,
        titre,
        corps,
        _tzLocal(prochaine),
        _details(canal),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        payload: _payload({...payload, 'alarmeBase': '$id', 'jour': '$jour'}),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
    return Future.value();
  }

  /// Déclenche immédiatement une alarme pleine puissance (canal alarme).
  Future<void> declencher(
    int id,
    String titre,
    String corps, {
    Map<String, String> payload = const <String, String>{},
  }) => _plugin.show(
        id,
        titre,
        corps,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'alarme_urgence',
            'to_doia — Alarmes',
            importance: Importance.max,
            priority: Priority.max,
            playSound: true,
            enableVibration: true,
            fullScreenIntent: true,
            category: AndroidNotificationCategory.alarm,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentSound: true,
            interruptionLevel: InterruptionLevel.timeSensitive,
          ),
        ),
        payload: _payload(payload),
      );

  /// Liste les notifications / alarmes encore attendues par l'OS.
  Future<List<PendingNotificationRequest>> enAttente() =>
      _plugin.pendingNotificationRequests();

  /// Annule une notification par son id (ou une base d'id si [baseId]).
  Future<void> annuler(int id) => _plugin.cancel(id);

  /// Annule toutes les notifications programmées de l'application.
  Future<void> toutAnnuler() => _plugin.cancelAll();

  /// Ferme le service (libère les callbacks, pas de ressource native à libérer
  /// ici : le plugin était déjà prêt).
  Future<void> arreter() async {
    onNotificationReponse = null;
    onNotificationFond = null;
    await toutAnnuler();
  }

  // ────────────────────────────── Helpers ────────────────────────────────

  NotificationDetails _details(String? canal) {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        canal ?? _canalIdDefaut,
        canal ?? _nomCanalDefaut,
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
      ),
      iOS: const DarwinNotificationDetails(presentAlert: true, presentSound: false, presentBadge: true),
    );
  }

  /// Le plugin exige un payload de type `String` sous Android ; on sérialise
  /// la map « clé=valeur » avec `&` (simple et suffisant pour ce module).
  String? _payload(Map<String, String> data) {
    if (data.isEmpty) return null;
    return data.entries.map((e) => '${e.key}=${e.value}').join('&');
  }

  tz.TZDateTime _tzLocal(DateTime local) => tz.TZDateTime.from(local, tz.local);

  DateTime _prochaineOccurrence(DateTime base, int jourSemaine) {
    var candidate = DateTime(
      base.year,
      base.month,
      base.day,
      base.hour,
      base.minute,
    );
    while (candidate.weekday != jourSemaine ||
        !candidate.isAfter(DateTime.now())) {
      candidate = candidate.add(const Duration(days: 1));
    }
    return candidate;
  }
}
