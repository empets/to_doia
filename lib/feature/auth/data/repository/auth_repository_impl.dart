import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grace_church/core/constante/global_params.dart';
import 'package:grace_church/core/service_systeme/error/failure.dart';
import 'package:grace_church/feature/auth/domaine/entities/utilisateur_entite.dart';
import 'package:grace_church/feature/auth/domaine/repositorie/auth_repository.dart';
import 'package:injectable/injectable.dart';

/// Implémentation Firebase Auth + Firestore du contrat [AuthRepository].
///
/// Firebase Auth gère les identifiants (e-mail / mot de passe). Le profil
/// public est enregistré dans la collection Firestore `users`, sous le
/// document `users/{uid}`. Le mot de passe n'est jamais écrit dans Firestore.
@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._auth, this._firestore);

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  static const String _collection = GlobalParams.userRealBdPath;

  @override
  Future<Either<Failure, UtilisateurEntite>> connecter({
    required String email,
    required String motDePasse,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: motDePasse,
      );

      final utilisateur = credential.user;
      if (utilisateur == null) {
        return const Left(Failure('Utilisateur introuvable après connexion.'));
      }

      final profil = await _lireProfil(utilisateur.uid);
      final entite = _mapper(utilisateur, profil: profil);

      // La session est déjà valide : une erreur de synchronisation du profil
      // ne doit pas bloquer la connexion. Elle sera retentée à la prochaine
      // ouverture de l'écran ou à la prochaine connexion.
      try {
        if (profil == null) {
          await _creerProfil(entite);
        } else {
          await _synchroniserProfil(entite);
        }
      } catch (_) {}

      return Right(entite);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(_messageErreur(e)));
    } catch (e) {
      return Left(Failure('Connexion impossible : $e'));
    }
  }

  @override
  Future<Either<Failure, UtilisateurEntite>> inscrire({
    required String nom,
    required String email,
    required String motDePasse,
  }) async {
    User? utilisateurCree;

    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: motDePasse,
      );

      final utilisateur = credential.user;
      if (utilisateur == null) {
        return const Left(
          Failure('Compte créé, mais utilisateur introuvable.'),
        );
      }
      utilisateurCree = utilisateur;

      // Le nom est un confort d'affichage : un échec ici ne doit pas annuler
      // la création du compte.
      final nomNettoye = nom.trim();
      if (nomNettoye.isNotEmpty) {
        try {
          await utilisateur.updateDisplayName(nomNettoye);
          await utilisateur.reload();
        } catch (_) {}
      }

      final entite = _mapper(
        _auth.currentUser ?? utilisateur,
        nomSecours: nomNettoye,
      );

      // Écriture du profil : si elle échoue, le compte Auth est annulé pour
      // que l'utilisateur puisse réessayer avec la même adresse e-mail.
      await _creerProfil(entite);

      return Right(entite);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(_messageErreur(e)));
    } catch (e) {
      if (utilisateurCree != null) {
        try {
          await utilisateurCree.delete();
        } catch (_) {}
      }
      return Left(Failure("Création du compte impossible : $e"));
    }
  }

  @override
  Future<Either<Failure, Unit>> deconnecter() async {
    try {
      await _auth.signOut();
      return const Right(unit);
    } catch (e) {
      return Left(Failure('Déconnexion impossible : $e'));
    }
  }

  @override
  Future<Either<Failure, UtilisateurEntite?>> utilisateurCourant() async {
    try {
      final utilisateur = _auth.currentUser;
      if (utilisateur == null) return const Right(null);

      final profil = await _lireProfil(utilisateur.uid);
      return Right(_mapper(utilisateur, profil: profil));
    } catch (e) {
      return Left(Failure('Lecture de la session impossible : $e'));
    }
  }

  @override
  Stream<UtilisateurEntite?> utilisateurCourantStream() =>
      _auth.userChanges().asyncMap((utilisateur) async {
        if (utilisateur == null) return null;
        final profil = await _lireProfil(utilisateur.uid);
        return _mapper(utilisateur, profil: profil);
      });

  /// Crée le document profil complet lors de l'inscription.
  Future<void> _creerProfil(UtilisateurEntite utilisateur) {
    return _firestore.collection(_collection).doc(utilisateur.uid).set({
      'uid': utilisateur.uid,
      'nom': utilisateur.nomAffiche,
      'email': utilisateur.email,
      'emailVerifie': utilisateur.emailVerifie,
      'statut': 'actif',
      'creeLe': FieldValue.serverTimestamp(),
      'derniereConnexion': FieldValue.serverTimestamp(),
    });
  }

  /// Met à jour les informations de connexion sans écraser la date de création.
  Future<void> _synchroniserProfil(UtilisateurEntite utilisateur) {
    return _firestore.collection(_collection).doc(utilisateur.uid).set({
      'uid': utilisateur.uid,
      'email': utilisateur.email,
      'emailVerifie': utilisateur.emailVerifie,
      'derniereConnexion': FieldValue.serverTimestamp(),
      if (utilisateur.nomAffiche.trim().isNotEmpty)
        'nom': utilisateur.nomAffiche,
    }, SetOptions(merge: true));
  }

  /// Lit le profil Firestore existant, ou `null` s'il n'existe pas / est
  /// inaccessible. Le profil Auth reste alors la source de secours.
  Future<Map<String, dynamic>?> _lireProfil(String uid) async {
    try {
      final snapshot = await _firestore.collection(_collection).doc(uid).get();
      return snapshot.data();
    } catch (_) {
      return null;
    }
  }

  UtilisateurEntite _mapper(
    User utilisateur, {
    Map<String, dynamic>? profil,
    String nomSecours = '',
  }) {
    final nomProfil = (profil?['nom'] as String?)?.trim() ?? '';
    final nomAuth = (utilisateur.displayName ?? '').trim();
    final nom = nomProfil.isNotEmpty
        ? nomProfil
        : nomAuth.isNotEmpty
        ? nomAuth
        : nomSecours;

    final emailProfil = (profil?['email'] as String?)?.trim() ?? '';

    return UtilisateurEntite(
      uid: utilisateur.uid,
      email: emailProfil.isNotEmpty ? emailProfil : utilisateur.email ?? '',
      nomAffiche: nom,
      emailVerifie:
          (profil?['emailVerifie'] as bool?) ?? utilisateur.emailVerified,
    );
  }

  /// Traduit les codes Firebase en messages compréhensibles par l'utilisateur.
  String _messageErreur(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Adresse e-mail invalide.';
      case 'user-disabled':
        return 'Ce compte a été désactivé.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'E-mail ou mot de passe incorrect.';
      case 'email-already-in-use':
        return 'Un compte existe déjà avec cette adresse e-mail.';
      case 'weak-password':
        return 'Le mot de passe est trop faible (8 caractères minimum).';
      case 'operation-not-allowed':
        return "La connexion par e-mail n'est pas activée.";
      case 'too-many-requests':
        return 'Trop de tentatives. Réessayez dans quelques minutes.';
      case 'network-request-failed':
        return 'Connexion Internet indisponible.';
      case 'requires-recent-login':
        return 'Reconnectez-vous pour effectuer cette action.';
      default:
        return 'Une erreur est survenue : ${e.message ?? e.code}';
    }
  }
}
