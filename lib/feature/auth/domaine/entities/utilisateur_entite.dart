import 'package:equatable/equatable.dart';

/// Utilisateur authentifié de l'application.
///
/// Cette entité ne dépend d'aucune implémentation : la couche data la construit
/// à partir de Firebase Auth.
class UtilisateurEntite extends Equatable {
  const UtilisateurEntite({
    required this.uid,
    required this.email,
    this.nomAffiche = '',
    this.emailVerifie = false,
  });

  final String uid;
  final String email;
  final String nomAffiche;
  final bool emailVerifie;

  /// Nom affichable : le nom saisi, sinon la partie locale de l'e-mail.
  String get nomAfficheOuEmail {
    final nom = nomAffiche.trim();
    if (nom.isNotEmpty) return nom;
    return email.split('@').first;
  }

  @override
  List<Object> get props => [uid, email, nomAffiche, emailVerifie];
}
