import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:grace_church/core/extention/app_extention.dart';
import 'package:grace_church/core/service_systeme/model/formz_model/text_formz.dart';
import 'package:grace_church/feature/home/domaine/entities/request/home_request.dart';
import 'package:grace_church/feature/home/domaine/usecase/create_task_usecase.dart';
import 'package:grace_church/feature/home/presentation/bloc/create_task.dart/event/create_tast_event.dart';

import 'state/create_tast_state.dart';

class FormTastBloc extends Bloc<CreateTaskEvent, CreateTastState> {
  FormTastBloc({required this.createTaskUseCase})
    : super(CreateTastState.initial()) {
    on<CreateTaskEvent>(createTast);
  }

  final CreateTaskUseCase createTaskUseCase;

  bool _validate({
    TextFormz? title,
    TextFormz? date,
    TextFormz? time,
    TextFormz? content,
    TextFormz? eventStatus,
  }) => Formz.validate([
    title ?? state.title,
    date ?? state.date,
    time ?? state.time,
    content ?? state.content,
    eventStatus ?? state.eventStatus,
  ]);

  Future<void> createTast(
    CreateTaskEvent event,
    Emitter<CreateTastState> emit,
  ) async {
    switch (event) {
      case ChangeTitleCreateTaskEvent(:final title):
        final input = TextFormz.dirty(title);
        emit(
          state.copyWith(
            title: input,
            status: FormzSubmissionStatus.initial,
            isValide: _validate(title: input),
          ),
        );
        break;

      case ChangeDateCreateTaskEvent(:final date):
        final input = TextFormz.dirty(date);
        emit(
          state.copyWith(
            date: input,
            status: FormzSubmissionStatus.initial,
            isValide: _validate(date: input),
          ),
        );
        break;

      case ChangeTimeCreateTaskEvent(:final time):
        final input = TextFormz.dirty(time);
        emit(
          state.copyWith(
            time: input,
            status: FormzSubmissionStatus.initial,
            isValide: _validate(time: input),
          ),
        );
        break;

      case ChangeRecurringCreateTaskEvent(:final recurring):
        emit(
          state.copyWith(
            recurring: recurring,
            status: FormzSubmissionStatus.initial,
          ),
        );
        break;

      case ChangeContentCreateTaskEvent(:final content):
        final input = TextFormz.dirty(content);
        emit(
          state.copyWith(
            content: input,
            status: FormzSubmissionStatus.initial,
            isValide: _validate(content: input),
          ),
        );
        break;

      case ChangeStatusCreateTaskEvent(:final status):
        final input = TextFormz.dirty(status);
        emit(
          state.copyWith(
            eventStatus: input,
            status: FormzSubmissionStatus.initial,
            isValide: _validate(eventStatus: input),
          ),
        );
        break;

      case ChangeTaskIdCreateTaskEvent(:final taskId):
        emit(
          state.copyWith(taskId: taskId, status: FormzSubmissionStatus.initial),
        );
        break;

      case SubmitCreateTaskEvent():
        if (state.isValide) {
          emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

          final response = await createTaskUseCase.call(
            RequestCreateTask(
              title: state.title.value,
              date: state.date.value,
              time: state.time.value,
              recurring: state.recurring,
              content: state.content.value,
              status: state.eventStatus.value,
            ),
          );

          emit(
            response.fold(
              (failure) {
                log(
                  "SubmitCreateTaskEvent failure: ${failure.message.getOrEmpty()}",
                );
                return state.copyWith(
                  errorMessage: failure.message.getOrEmpty(),
                  status: FormzSubmissionStatus.failure,
                );
              },
              (success) =>
                  state.copyWith(status: FormzSubmissionStatus.success),
            ),
          );
        }

        break;
    }
  }
}
