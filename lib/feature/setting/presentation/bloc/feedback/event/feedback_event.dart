import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grace_church/feature/setting/domaine/entities/feedback_entite.dart';

part 'feedback_event.freezed.dart';

@freezed
abstract class FeedbackEvent with _$FeedbackEvent {
  /// Le message saisi a changé (champ facultatif).
  factory FeedbackEvent.messageChanged(String message) =
      MessageChangedFeedbackEvent;

  /// L'e-mail saisi a changé (champ facultatif).
  factory FeedbackEvent.emailChanged(String email) = EmailChangedFeedbackEvent;

  /// Le type de retour sélectionné a changé.
  factory FeedbackEvent.typeChanged(TypeFeedback type) =
      TypeChangedFeedbackEvent;

  /// Demande d'envoi du formulaire.
  factory FeedbackEvent.submitted() = SubmittedFeedbackEvent;

  /// Remise à zéro après un envoi réussi.
  factory FeedbackEvent.reinitialise() = ReinitialiseFeedbackEvent;
}
