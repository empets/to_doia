/// Entité métier : alarme.
///
/// Indépendante de toute implémentation technique (flutter_local_notifications,
/// timezone, etc.). Elle décrit UNE alarme de manière agnostique pour que les
/// usecases et les repositories du domaine restent purs.
class AlarmeEntite {
  const AlarmeEntite({
    required this.id,
    required this.titre,
    required this.corps,
    required this.dateHeure,
    this.joursDeRepetition = const <int, bool>{},
    this.channelId = AppCanauxAlarme.paroisien,
    this.enAttente = false,
    this.payload = const <String, String>{},
  });

  /// Identifiant unique de l'alarme (stable pour Android/iOS,
  /// doit tenir dans 32 bits → entier positif inférieur à 2^31).
  final int id;

  /// Titre affiché dans la notification d'alarme.
  final String titre;

  /// Corps (message) affiché dans la notification d'alarme.
  final String corps;

  /// Date et heure de déclenchement (heure locale de l'appareil).
  final DateTime dateHeure;

  /// Répétition hebdomadaire.
  /// Clé : jour de la semaine (1 = lundi … 7 = dimanche, convention DateTime).
  /// Valeur : actif ce jour-là.
  ///
  /// Une map vide ⇒ alarme ponctuelle (pas de répétition).
  final Map<int, bool> joursDeRepetition;

  /// Canal Android sur lequel l'alarme est déclenchée.
  final String channelId;

  /// Vrai tant que l'alarme n'a pas encore sonné (utile pour l'historique).
  final bool enAttente;

  /// Données libres transportées par la notification (route, id métier…).
  final Map<String, String> payload;

  AlarmeEntite copyWith({
    int? id,
    String? titre,
    String? corps,
    DateTime? dateHeure,
    Map<int, bool>? joursDeRepetition,
    String? channelId,
    bool? enAttente,
    Map<String, String>? payload,
  }) {
    return AlarmeEntite(
      id: id ?? this.id,
      titre: titre ?? this.titre,
      corps: corps ?? this.corps,
      dateHeure: dateHeure ?? this.dateHeure,
      joursDeRepetition: joursDeRepetition ?? this.joursDeRepetition,
      channelId: channelId ?? this.channelId,
      enAttente: enAttente ?? this.enAttente,
      payload: payload ?? this.payload,
    );
  }

  /// Sérialisation (persistance locale des alarmes programmées, pour
  /// re-programmation après redémarrage du téléphone).
  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'titre': titre,
    'corps': corps,
    'dateHeure': dateHeure.toIso8601String(),
    // JSON n'autorise que des clés de map de type String. Le domaine utilise
    // des clés int (1 = lundi ... 7 = dimanche), donc on les convertit ici.
    'joursDeRepetition': joursDeRepetition.map(
      (jour, actif) => MapEntry(jour.toString(), actif),
    ),
    'channelId': channelId,
    'enAttente': enAttente,
    'payload': payload,
  };

  /// Désérialisation ; retourne `null` si le JSON est invalide.
  static AlarmeEntite? fromJson(Map<String, dynamic> json) {
    try {
      final joursBrut = json['joursDeRepetition'] is Map
          ? Map<Object?, Object?>.from(json['joursDeRepetition'] as Map)
          : const <Object?, Object?>{};
      return AlarmeEntite(
        id: json['id'] as int,
        titre: json['titre'] as String? ?? '',
        corps: json['corps'] as String? ?? '',
        dateHeure: DateTime.parse(json['dateHeure'] as String),
        joursDeRepetition: joursBrut.map(
          (k, v) => MapEntry(int.parse(k.toString()), v == true),
        ),
        channelId: json['channelId'] as String? ?? AppCanauxAlarme.paroisien,
        enAttente: json['enAttente'] as bool? ?? false,
        payload:
            (json['payload'] as Map<String, dynamic>?)?.map(
              (k, v) => MapEntry(k, v.toString()),
            ) ??
            const {},
      );
    } catch (_) {
      return null;
    }
  }
}

/// Identifiants des canaux de notification (Android ≤ 8 ne les utilisent que
/// pour le tri / le son ; iOS les ignore). Centralisés pour éviter les fautes.
class AppCanauxAlarme {
  static const String alarme = 'alarme_urgence';
  static const String paroisien = 'notification_generale';
  static const String rappel = 'rappel_evenement';
}
