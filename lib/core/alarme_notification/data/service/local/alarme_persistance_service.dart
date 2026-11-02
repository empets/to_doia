import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:grace_church/core/alarme_notification/domaine/entities/alarme_entite.dart';
import 'package:grace_church/core/alarme_notification/data/service/notification_local_service.dart';

/// Persistance locale des alarmes programmées.
///
/// Sous Android, les alarmes ponctuelles sont **effacées au redémarrage du
/// téléphone** : ce service garde chacune des alarmes en JSON (shared_preferences)
/// afin que [AlarmeNotificationService] puisse les re-programmer au démarrage
/// de l'application.
@lazySingleton
class AlarmePersistanceService {
  static const String _cle = 'core_alarme_notification.alarmes';

  /// Injecté preResolve par le module d'injection du projet.
  AlarmePersistanceService(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  /// Ajoute / remplace une alarme persistée (clé = id).
  Future<void> sauvegarder(AlarmeEntite alarme) async {
    final map = _chargerMap();
    map[alarme.id.toString()] = alarme.toJson();
    await _ecrireMap(map);
  }

  /// Supprime une alarme persistée par son id (+ dérivés `id*10+jour`).
  Future<void> supprimer(int idAlarme) async {
    final map = _chargerMap();
    for (var jour = 1; jour <= 7; jour++) {
      map.remove((idAlarme * 10 + jour).toString());
    }
    map.remove(idAlarme.toString());
    await _ecrireMap(map);
  }

  /// Supprime toutes les alarmes persistées.
  Future<void> toutSupprimer() async {
    await _sharedPreferences.remove(_cle);
  }

  /// Toutes les alarmes encore pertinentes :
  /// - répétées → toujours conservées,
  /// - ponctuelles → conservées tant que [dateHeure] est dans le futur,
  ///   sinon purgées et ignorées.
  List<AlarmeEntite> alarmesActives() {
    final actives = <AlarmeEntite>[];
    final map = _chargerMap();
    var modifie = false;
    for (final entry in map.entries.toList()) {
      final alarme = AlarmeEntite.fromJson(
        Map<String, dynamic>.from(entry.value as Map),
      );
      if (alarme == null) {
        map.remove(entry.key);
        modifie = true;
        continue;
      }
      final repetee = alarme.joursDeRepetition.values.any((actif) => actif);
      if (!repetee && alarme.dateHeure.isBefore(DateTime.now())) {
        map.remove(entry.key);
        modifie = true;
        continue;
      }
      actives.add(alarme);
    }
    if (modifie) _ecrireMap(map);
    return actives;
  }

  Map<String, dynamic> _chargerMap() {
    final brut = _sharedPreferences.getString(_cle);
    if (brut == null || brut.isEmpty) return {};
    try {
      return (jsonDecode(brut) as Map<String, dynamic>).map(
        (cle, valeur) => MapEntry(cle, valeur),
      );
    } catch (e) {
      throw NotificationServiceException(e.toString());
    }
  }

  Future<void> _ecrireMap(Map<String, dynamic> map) =>
      _sharedPreferences.setString(_cle, jsonEncode(map));
}
