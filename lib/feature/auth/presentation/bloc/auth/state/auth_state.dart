import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grace_church/core/service_systeme/model/formz_model/confirmation_mot_de_passe_formz.dart';
import 'package:grace_church/core/service_systeme/model/formz_model/email_formz.dart';
import 'package:grace_church/core/service_systeme/model/formz_model/password_text_formz.dart';
import 'package:grace_church/core/service_systeme/model/formz_model/text_formz.dart';
import 'package:grace_church/feature/auth/domaine/entities/utilisateur_entite.dart';

part 'auth_state.freezed.dart';

/// Écran demandé par l'utilisateur.
enum ModeAuthentification {
  connexion('Connexion', 'Se connecter'),
  inscription('Inscription', 'Créer un compte');

  const ModeAuthentification(this.libelle, this.actionLibelle);

  final String libelle;
  final String actionLibelle;
}

@freezed
abstract class AuthState with _$AuthState {
  factory AuthState({
    required TextFormz nom,
    required EmailFormz email,
    required PasswordTextFormz motDePasse,
    required ConfirmationMotDePasseFormz confirmation,
    required ModeAuthentification mode,
    required FormzSubmissionStatus status,
    required String errorMessage,
    required bool isValide,
    required UtilisateurEntite? utilisateur,
    required bool sessionVerifiee,
  }) = _AuthState;

  factory AuthState.initial() => AuthState(
    nom: const TextFormz.pure(),
    email: const EmailFormz.pure(),
    motDePasse: const PasswordTextFormz.pure(),
    confirmation: const ConfirmationMotDePasseFormz.pure(),
    mode: ModeAuthentification.connexion,
    status: FormzSubmissionStatus.initial,
    errorMessage: '',
    isValide: false,
    utilisateur: null,
    sessionVerifiee: false,
  );
}
