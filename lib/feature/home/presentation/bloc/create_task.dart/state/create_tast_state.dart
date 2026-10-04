

import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grace_church/core/service_systeme/model/formz_model/text_formz.dart';

part 'create_tast_state.freezed.dart';

@freezed
abstract class CreateTastState with _$CreateTastState {
  factory CreateTastState({
    required TextFormz title,
    required TextFormz date,
    required TextFormz time,
    required bool recurring,
    required TextFormz content,
    required TextFormz eventStatus,
    required String taskId,
    required FormzSubmissionStatus status,
    required String errorMessage,
    required bool isValide,
  }) = _CreateTastState;

  factory CreateTastState.initial() => CreateTastState(
    title: TextFormz.pure(),
    date: TextFormz.pure(),
    time: TextFormz.pure(),
    recurring: false,
    content: TextFormz.pure(),
    eventStatus: TextFormz.pure(),
    taskId: '',
    status: FormzSubmissionStatus.initial,
    errorMessage: '',
    isValide: false,
  );
}