import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grace_church/core/service_systeme/model/formz_model/champ_facultatif_formz.dart';
import 'package:grace_church/feature/setting/domaine/entities/feedback_entite.dart';

part 'feedback_state.freezed.dart';

@freezed
abstract class FeedbackState with _$FeedbackState {
  factory FeedbackState({
    required TextFacultatifFormz message,
    required EmailFacultatifFormz email,
    required TypeFeedback type,
    required FormzSubmissionStatus status,
    required String errorMessage,
    required bool isValide,
  }) = _FeedbackState;

  factory FeedbackState.initial() => FeedbackState(
    message: const TextFacultatifFormz.pure(),
    email: const EmailFacultatifFormz.pure(),
    type: TypeFeedback.bug,
    status: FormzSubmissionStatus.initial,
    errorMessage: '',
    isValide: true,
  );
}
