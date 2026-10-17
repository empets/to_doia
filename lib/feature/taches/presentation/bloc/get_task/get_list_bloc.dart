import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grace_church/core/service_systeme/model/api/api_state.dart';
import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';
import 'package:grace_church/feature/taches/domaine/entities/request/task_request.dart';
import 'package:grace_church/feature/taches/domaine/usecase/get_task_list_usecase.dart';
import 'package:grace_church/feature/taches/presentation/bloc/get_task/event/task_event.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetListBloc extends Bloc<TaskSectionEvent, ApiState<List<TaskResponse>>> {
  GetListBloc({required this.getTaskListUseCase})
    : super(ApiState<List<TaskResponse>>.initial()) {
    on<TaskSectionEvent>(_getList);
  }

  final GetTaskListUseCase getTaskListUseCase;

  Future<void> _getList(
    TaskSectionEvent event,
    Emitter<ApiState<List<TaskResponse>>> emit,
  ) async {
    switch (event) {
      case FetchTaskSectionEvent(:final id):
        if (id != null) {
          emit(ApiState<List<TaskResponse>>.load());
          final response = await getTaskListUseCase.call(
            RequestNotParams(id: id),
          );
          response.fold(
            (l) {
              emit(ApiState<List<TaskResponse>>.failed(l.message));
            },
            (r) {
              emit(ApiState<List<TaskResponse>>.success(r));
            },
          );
        } else {
          emit(ApiState<List<TaskResponse>>.load());
          final response = await getTaskListUseCase.call(RequestNotParams());
          response.fold(
            (l) {
              emit(ApiState<List<TaskResponse>>.failed(l.message));
            },
            (r) {
              emit(ApiState<List<TaskResponse>>.success(r));
            },
          );
        }
      case ChangeTaskSectionEvent(:final task):
        if (state is SuccessState<List<TaskResponse>>) {
          if (task != null) {
            final updatedTasks =
                (state as SuccessState<List<TaskResponse>>).data;

            final newTasks = updatedTasks.map((t) {
              if (t.taskId.trim() == task.taskId.trim()) {
                return t.copyWith(
                  status: task.status,
                  title: task.title,
                  date: task.date,
                  time: task.time,
                  recurring: task.recurring,
                  content: task.content,
                );
              }

              return t;
            }).toList();

            emit(ApiState<List<TaskResponse>>.success(newTasks));
          }
        }

        case ChangeTaskStatusSectionEvent(:final task, :final status):
          if (state is SuccessState<List<TaskResponse>>) {
            if (task != null) {
              final updatedTasks =
                  (state as SuccessState<List<TaskResponse>>).data;

              final newTasks = updatedTasks.map((t) {
                if (t.taskId.trim() == task.taskId.trim()) {
                  return t.copyWith(
                  status: status,
                  title: task.title,
                  date: task.date,
                  time: task.time,
                  recurring: task.recurring,
                  content: task.content,

                  );
                }
                return t;
              }).toList();

              emit(ApiState<List<TaskResponse>>.success(newTasks));
            }
          }
       case SearchTaskSectionEvent(:final search):
            if (state is SuccessState<List<TaskResponse>>) {
            if (search != null) {
              final updatedTasks =
                  (state as SuccessState<List<TaskResponse>>).data;

              final newTasks = updatedTasks.where((t) {
                return t.title.toLowerCase().contains(search.toLowerCase()) || t.content.toLowerCase().contains(search.toLowerCase());
              }).toList();

              emit(ApiState<List<TaskResponse>>.success(newTasks.isNotEmpty ? newTasks : <TaskResponse>[],refresh: true));
            }
          }
    }
  }
}


