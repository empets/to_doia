import 'package:equatable/equatable.dart';

/// Nature du retour envoyé depuis les paramètres.
enum TypeFeedback {
  bug('bug', 'Signaler un bug'),
  suggestion('suggestion', 'Suggestion'),
  autre('autre', 'Autre');

  const TypeFeedback(this.code, this.libelle);

  /// Valeur stable enregistrée dans Firestore.
  final String code;

  /// Libellé affiché à l'utilisateur.
  final String libelle;
}

/// Retour utilisateur saisi dans l'écran « Envoyer un retour ».
///
/// Cette entité ne contient que les informations saisies par l'utilisateur.
/// Les métadonnées de diagnostic (appareil, système, version de l'app) sont
/// ajoutées par la couche data au moment de l'envoi.
class FeedbackEntite extends Equatable {
  const FeedbackEntite({
    required this.type,
    required this.message,
    this.email = '',
  });

  final TypeFeedback type;
  final String message;
  final String email;

  /// Données saisies, prêtes à être fusionnées avec les métadonnées d'envoi.
  Map<String, dynamic> toMap() => {
    'type': type.code,
    'typeLibelle': type.libelle,
    'message': message,
    'email': email,
  };

  @override
  List<Object> get props => [type, message, email];
}
