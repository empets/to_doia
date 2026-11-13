import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:grace_church/core/service_systeme/model/formz_model/confirmation_mot_de_passe_formz.dart';
import 'package:grace_church/core/service_systeme/model/formz_model/email_formz.dart';
import 'package:grace_church/core/service_systeme/model/formz_model/password_text_formz.dart';
import 'package:grace_church/core/service_systeme/model/formz_model/text_formz.dart';
import 'package:grace_church/core/service_systeme/usercase/usercase.dart';
import 'package:grace_church/feature/auth/domaine/usecase/connecter_utilisateur_usecase.dart';
import 'package:grace_church/feature/auth/domaine/usecase/deconnecter_utilisateur_usecase.dart';
import 'package:grace_church/feature/auth/domaine/usecase/inscrire_utilisateur_usecase.dart';
import 'package:grace_church/feature/auth/domaine/usecase/utilisateur_courant_usecase.dart';
import 'package:grace_church/feature/auth/presentation/bloc/auth/event/auth_event.dart';

import 'state/auth_state.dart';

/// Gère le formulaire d'authentification : connexion, inscription, déconnexion.
///
/// Toute la validation des champs est portée par des `FormzInput`, l'état est
/// exposé par un [AuthState] immuable.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required ConnecterUtilisateurUseCase connecter,
    required InscrireUtilisateurUseCase inscrire,
    required DeconnecterUtilisateurUseCase deconnecter,
    required UtilisateurCourantUseCase utilisateurCourant,
  }) : _connecter = connecter,
       _inscrire = inscrire,
       _deconnecter = deconnecter,
       _utilisateurCourant = utilisateurCourant,
       super(AuthState.initial()) {
    on<AuthEvent>(_onEvent);
  }

  final ConnecterUtilisateurUseCase _connecter;
  final InscrireUtilisateurUseCase _inscrire;
  final DeconnecterUtilisateurUseCase _deconnecter;
  final UtilisateurCourantUseCase _utilisateurCourant;

  bool _valide({
    TextFormz? nom,
    EmailFormz? email,
    PasswordTextFormz? motDePasse,
    ConfirmationMotDePasseFormz? confirmation,
    ModeAuthentification? mode,
  }) {
    final modeCourant = mode ?? state.mode;
    final champs = <FormzInput<dynamic, dynamic>>[
      email ?? state.email,
      motDePasse ?? state.motDePasse,
      if (modeCourant == ModeAuthentification.inscription) ...[
        nom ?? state.nom,
        confirmation ?? state.confirmation,
      ],
    ];
    return Formz.validate(champs);
  }

  Future<void> _onEvent(AuthEvent event, Emitter<AuthState> emit) async {
    switch (event) {
      case NomChangedAuthEvent(:final nom):
        final input = TextFormz.dirty(nom);
        emit(
          state.copyWith(
            nom: input,
            status: FormzSubmissionStatus.initial,
            errorMessage: '',
            isValide: _valide(nom: input),
          ),
        );

      case EmailChangedAuthEvent(:final email):
        final input = EmailFormz.dirty(email);
        emit(
          state.copyWith(
            email: input,
            status: FormzSubmissionStatus.initial,
            errorMessage: '',
            isValide: _valide(email: input),
          ),
        );

      case MotDePasseChangedAuthEvent(:final motDePasse):
        final input = PasswordTextFormz.dirty(motDePasse);
        final confirmation = ConfirmationMotDePasseFormz.dirty(
          state.confirmation.value,
          input.value,
        );
        emit(
          state.copyWith(
            motDePasse: input,
            confirmation: confirmation,
            status: FormzSubmissionStatus.initial,
            errorMessage: '',
            isValide: _valide(motDePasse: input, confirmation: confirmation),
          ),
        );

      case ConfirmationChangedAuthEvent(:final confirmation):
        final input = ConfirmationMotDePasseFormz.dirty(
          confirmation,
          state.motDePasse.value,
        );
        emit(
          state.copyWith(
            confirmation: input,
            status: FormzSubmissionStatus.initial,
            errorMessage: '',
            isValide: _valide(confirmation: input),
          ),
        );

      case ModeChangedAuthEvent(:final mode):
        if (mode == state.mode) return;
        emit(
          state.copyWith(
            mode: mode,
            nom: const TextFormz.pure(),
            motDePasse: const PasswordTextFormz.pure(),
            confirmation: const ConfirmationMotDePasseFormz.pure(),
            status: FormzSubmissionStatus.initial,
            errorMessage: '',
            isValide: _valide(
              nom: const TextFormz.pure(),
              motDePasse: const PasswordTextFormz.pure(),
              confirmation: const ConfirmationMotDePasseFormz.pure(),
              mode: mode,
            ),
          ),
        );

      case SessionVerifieeAuthEvent():
        final result = await _utilisateurCourant(EmptyRequest());
        result.fold(
          (failure) => emit(
            state.copyWith(
              sessionVerifiee: true,
              errorMessage: failure.message,
            ),
          ),
          (utilisateur) => emit(
            state.copyWith(
              sessionVerifiee: true,
              utilisateur: utilisateur,
              errorMessage: '',
            ),
          ),
        );

      case SoumisAuthEvent():
        if (state.status.isInProgress || !_valide()) return;

        final mode = state.mode;
        emit(
          state.copyWith(
            status: FormzSubmissionStatus.inProgress,
            errorMessage: '',
          ),
        );

        final resultat = mode == ModeAuthentification.connexion
            ? await _connecter(
                ConnexionParams(
                  email: state.email.value.trim(),
                  motDePasse: state.motDePasse.value,
                ),
              )
            : await _inscrire(
                InscriptionParams(
                  nom: state.nom.value.trim(),
                  email: state.email.value.trim(),
                  motDePasse: state.motDePasse.value,
                ),
              );

        resultat.fold(
          (failure) => emit(
            state.copyWith(
              status: FormzSubmissionStatus.failure,
              errorMessage: failure.message,
            ),
          ),
          (utilisateur) => emit(
            state.copyWith(
              status: FormzSubmissionStatus.success,
              utilisateur: utilisateur,
              errorMessage: '',
            ),
          ),
        );

      case DeconnexionDemandeeAuthEvent():
        if (state.status.isInProgress) return;

        emit(
          state.copyWith(
            status: FormzSubmissionStatus.inProgress,
            errorMessage: '',
          ),
        );

        final result = await _deconnecter(EmptyRequest());
        result.fold(
          (failure) => emit(
            state.copyWith(
              status: FormzSubmissionStatus.failure,
              errorMessage: failure.message,
            ),
          ),
          (_) => emit(
            state.copyWith(
              utilisateur: null,
              nom: const TextFormz.pure(),
              email: const EmailFormz.pure(),
              motDePasse: const PasswordTextFormz.pure(),
              confirmation: const ConfirmationMotDePasseFormz.pure(),
              status: FormzSubmissionStatus.success,
              errorMessage: '',
              isValide: false,
              sessionVerifiee: true,
            ),
          ),
        );
    }
  }
}
