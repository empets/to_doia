import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grace_church/feature/auth/presentation/bloc/auth/state/auth_state.dart';

part 'auth_event.freezed.dart';

@freezed
abstract class AuthEvent with _$AuthEvent {
  /// Le nom saisi a changé.
  factory AuthEvent.nomChanged(String nom) = NomChangedAuthEvent;

  /// L'e-mail saisi a changé.
  factory AuthEvent.emailChanged(String email) = EmailChangedAuthEvent;

  /// Le mot de passe saisi a changé.
  factory AuthEvent.motDePasseChanged(String motDePasse) =
      MotDePasseChangedAuthEvent;

  /// La confirmation du mot de passe a changé.
  factory AuthEvent.confirmationChanged(String confirmation) =
      ConfirmationChangedAuthEvent;

  /// Bascule entre connexion et inscription.
  factory AuthEvent.modeChanged(ModeAuthentification mode) =
      ModeChangedAuthEvent;

  /// Vérifie si une session existe déjà au chargement de l'écran.
  factory AuthEvent.sessionVerifiee() = SessionVerifieeAuthEvent;

  /// Demande de connexion ou de création de compte.
  factory AuthEvent.soumis() = SoumisAuthEvent;

  /// Demande de déconnexion.
  factory AuthEvent.deconnexionDemandee() = DeconnexionDemandeeAuthEvent;
}
