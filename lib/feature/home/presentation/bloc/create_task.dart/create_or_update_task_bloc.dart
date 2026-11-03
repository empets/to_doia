import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:grace_church/core/alarme_notification/domaine/task_reminder_manager.dart';
import 'package:grace_church/core/constante/constantes.dart';
import 'package:grace_church/core/extention/app_extention.dart';
import 'package:grace_church/core/injetction/injection_container.dart';
import 'package:grace_church/core/service_systeme/model/formz_model/text_formz.dart';
import 'package:grace_church/feature/home/domaine/entities/request/home_request.dart';
import 'package:grace_church/feature/home/domaine/usecase/create_task_usecase.dart';
import 'package:grace_church/feature/home/domaine/usecase/update_task_from_usercase.dart';
import 'package:grace_church/feature/home/presentation/bloc/create_task.dart/event/create_tast_event.dart';

import 'state/create_tast_state.dart';

class FormTastBloc extends Bloc<CreateTaskEvent, CreateTastState> {
  FormTastBloc({
    required this.createTaskUseCase,
    required this.updateTaskUseCase,
    TaskReminderManager? taskReminder,
  }) : _taskReminder = taskReminder,
       super(CreateTastState.initial()) {
    on<CreateTaskEvent>(createTast);
  }

  final CreateTaskUseCase createTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;

  /// Coordination alarme/notification (résolue via l'injection si absente).
  final TaskReminderManager? _taskReminder;
  TaskReminderManager get _reminder =>
      _taskReminder ?? getIt<TaskReminderManager>();

  /// Programme le rappel après un enregistrement RÉUSSI.
  /// Jamais appelé si l'API a échoué (voir les branches `failure`).
  Future<void> _programmerRappel({required String taskId}) async {
    // Une tâche terminée/annulée ne doit pas sonner.
    if (state.eventStatus.value.contains(TypeTaskStatus.TERMINER) ||
        state.eventStatus.value.contains(TypeTaskStatus.ANNULER)) {
      return;
    }
    await _reminder.programmer(
      taskId,
      TaskReminderInfos(
        title: state.title.value,
        date: state.date.value,
        time: state.time.value,
        recurring: state.recurring,
      ),
    );
  }

  bool _validate({
    TextFormz? title,
    TextFormz? date,
    TextFormz? time,
    TextFormz? content,
    TextFormz? eventStatus,
    TextFormz? actionType,
  }) => Formz.validate([
    title ?? state.title,
    date ?? state.date,
    time ?? state.time,
    content ?? state.content,
    eventStatus ?? state.eventStatus,
    actionType ?? state.actionType,
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
        final input = TextFormz.dirty(taskId);
        emit(
          state.copyWith(taskId: input, status: FormzSubmissionStatus.initial),
        );
        break;
      case ActionTypeInfoCreateTaskEvent(:final actionType):
        final input = TextFormz.dirty(actionType);
        emit(
          state.copyWith(
            actionType: input,
            status: FormzSubmissionStatus.initial,
            isValide: _validate(actionType: input),
          ),
        );
        break;

      case SubmitCreateTaskEvent():
        if (state.isValide) {
          emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

          if (state.actionType.value.contains(
            TypeCreateTaskOrUpdate.CREATE_TASK,
          )) {
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

            // ⚠️ L'alarme n'est programmée QUE si l'API a réussi.
            await response.fold(
              (failure) async {
                log(
                  "SubmitCreateTaskEvent failure: ${failure.message}",
                );
                emit(
                  state.copyWith(
                    errorMessage: failure.message,
                    status: FormzSubmissionStatus.failure,
                  ),
                );
              },
              (success) async {
                await _programmerRappel(taskId: success ?? '');
                emit(state.copyWith(status: FormzSubmissionStatus.success));
              },
            );
          }

          if (state.actionType.value.contains(
            TypeCreateTaskOrUpdate.UPDATE_TASK,
          )) {
            log("SubmitCreateTaskEvent failure: ${state.title.value}");
            final response = await updateTaskUseCase.call(
              RequestCreateTask(
                title: state.title.value,
                date: state.date.value,
                time: state.time.value,
                recurring: state.recurring,
                content: state.content.value,
                status: state.eventStatus.value,
                taskId: state.taskId.value,
              ),
            );

            // Modification réussie → re-programmation (annule + recrée
            // l'occurrence avec le même id de tâche).
            await response.fold(
              (failure) async {
                emit(
                  state.copyWith(
                    errorMessage: failure.message,
                    status: FormzSubmissionStatus.failure,
                  ),
                );
              },
              (success) async {
                await _programmerRappel(taskId: state.taskId.value);
                emit(state.copyWith(status: FormzSubmissionStatus.success));
              },
            );
          }
        }

        break;
    }
  }
}
