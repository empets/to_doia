import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:grace_church/core/service_systeme/model/formz_model/champ_facultatif_formz.dart';
import 'package:grace_church/feature/setting/domaine/entities/feedback_entite.dart';
import 'package:grace_church/feature/setting/domaine/usecase/envoyer_feedback_usecase.dart';
import 'package:grace_church/feature/setting/presentation/bloc/feedback/event/feedback_event.dart';

import 'state/feedback_state.dart';

/// Gère le formulaire « Envoyer un retour ».
///
/// Tous les champs sont facultatifs : seul le format de l'e-mail est vérifié
/// lorsqu'il est renseigné.
class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  FeedbackBloc(this._envoyerFeedback) : super(FeedbackState.initial()) {
    on<FeedbackEvent>(_onEvent);
  }

  final EnvoyerFeedbackUseCase _envoyerFeedback;

  bool _validate({TextFacultatifFormz? message, EmailFacultatifFormz? email}) =>
      Formz.validate([message ?? state.message, email ?? state.email]);

  Future<void> _onEvent(
    FeedbackEvent event,
    Emitter<FeedbackState> emit,
  ) async {
    switch (event) {
      case MessageChangedFeedbackEvent(:final message):
        final input = TextFacultatifFormz.dirty(message);
        emit(
          state.copyWith(
            message: input,
            status: FormzSubmissionStatus.initial,
            errorMessage: '',
            isValide: _validate(message: input),
          ),
        );

      case EmailChangedFeedbackEvent(:final email):
        final input = EmailFacultatifFormz.dirty(email);
        emit(
          state.copyWith(
            email: input,
            status: FormzSubmissionStatus.initial,
            errorMessage: '',
            isValide: _validate(email: input),
          ),
        );

      case TypeChangedFeedbackEvent(:final type):
        emit(
          state.copyWith(
            type: type,
            status: FormzSubmissionStatus.initial,
            errorMessage: '',
          ),
        );

      case SubmittedFeedbackEvent():
        if (state.status.isInProgress) return;
        if (!state.isValide) return;

        emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

        final result = await _envoyerFeedback(
          FeedbackEntite(
            type: state.type,
            message: state.message.value.trim(),
            email: state.email.value.trim(),
          ),
        );

        result.fold(
          (failure) => emit(
            state.copyWith(
              status: FormzSubmissionStatus.failure,
              errorMessage: failure.message,
            ),
          ),
          (_) => emit(state.copyWith(status: FormzSubmissionStatus.success)),
        );

      case ReinitialiseFeedbackEvent():
        emit(FeedbackState.initial());
    }
  }
}
