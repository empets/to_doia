import 'alarme_entite.dart';

/// Entité métier : notification programmée.
///
/// Différente d'une [AlarmeEntite] : une notification programmée est un rappel
/// ponctuel silencieux ou discret, sans action système de réveil, déclenché à
/// une date/heure précise.
class NotificationProgrammeeEntite {
  const NotificationProgrammeeEntite({
    required this.id,
    required this.titre,
    required this.corps,
    required this.dateHeure,
    this.canalId = AppCanauxAlarme.paroisien,
    this.payload = const <String, String>{},
  });

  /// Identifiant unique de la notification (doit tenir sur 32 bits).
  final int id;

  /// Titre affiché dans la notification système.
  final String titre;

  /// Corps (message) affiché dans la notification système.
  final String corps;

  /// Date et heure de déclenchement (heure locale de l'appareil).
  final DateTime dateHeure;

  /// Canal Android de la notification.
  final String canalId;

  /// Données libres transportées par la notification (route, id métier…).
  final Map<String, String> payload;

  NotificationProgrammeeEntite copyWith({
    int? id,
    String? titre,
    String? corps,
    DateTime? dateHeure,
    String? canalId,
    Map<String, String>? payload,
  }) {
    return NotificationProgrammeeEntite(
      id: id ?? this.id,
      titre: titre ?? this.titre,
      corps: corps ?? this.corps,
      dateHeure: dateHeure ?? this.dateHeure,
      canalId: canalId ?? this.canalId,
      payload: payload ?? this.payload,
    );
  }
}

/// Identifiants des canaux de notification locales (Android).
class AppCanauxNotification {
  static const String notification = 'notification_locale';
  static const String rappel = 'rappel_programme';
}
