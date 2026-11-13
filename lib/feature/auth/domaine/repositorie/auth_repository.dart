import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:grace_church/core/service_systeme/error/failure.dart';
import 'package:grace_church/feature/auth/domaine/entities/utilisateur_entite.dart';

/// Contrat d'authentification de l'application.
///
/// L'implémentation Firebase se trouve dans la couche data ; le domaine ne
/// connaît que cette interface.
abstract class AuthRepository {
  /// Connecte un utilisateur avec e-mail et mot de passe.
  Future<Either<Failure, UtilisateurEntite>> connecter({
    required String email,
    required String motDePasse,
  });

  /// Crée un compte avec nom, e-mail et mot de passe.
  Future<Either<Failure, UtilisateurEntite>> inscrire({
    required String nom,
    required String email,
    required String motDePasse,
  });

  /// Déconnecte l'utilisateur courant.
  Future<Either<Failure, Unit>> deconnecter();

  /// Retourne l'utilisateur déjà connecté, ou `null` si la session est vide.
  Future<Either<Failure, UtilisateurEntite?>> utilisateurCourant();

  /// Diffuse l'utilisateur connecté et ses changements (connexion, profil,
  /// déconnexion). Utilisé par la bannière du compte dans les paramètres.
  Stream<UtilisateurEntite?> utilisateurCourantStream();
}
