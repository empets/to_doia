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
              log("new tacke ==> ${[r]}");
              emit(ApiState<List<TaskResponse>>.success(r));
            },
          );
        }
    }
  }
}
