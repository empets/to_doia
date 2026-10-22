// import 'dart:developer';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:grace_church/core/service_systeme/model/api/api_state.dart';
// import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';
// import 'package:grace_church/feature/taches/domaine/entities/request/task_request.dart';
// import 'package:grace_church/feature/taches/domaine/usecase/get_task_list_usecase.dart';
// import 'package:grace_church/feature/taches/presentation/bloc/get_task/event/task_event.dart';
// import 'package:injectable/injectable.dart';

// @lazySingleton
// class GetListBloc extends Bloc<TaskSectionEvent, ApiState<List<TaskResponse>>> {
//   GetListBloc({required this.getTaskListUseCase})
//     : super(ApiState<List<TaskResponse>>.initial()) {
//     on<TaskSectionEvent>(_getList);
//   }

//   final GetTaskListUseCase getTaskListUseCase;

//   Future<void> _getList(
//     TaskSectionEvent event,
//     Emitter<ApiState<List<TaskResponse>>> emit,
//   ) async {
//     switch (event) {
      // case FetchTaskSectionEvent(:final id):
      //   if (id != null) {
      //     emit(ApiState<List<TaskResponse>>.load());
      //     final response = await getTaskListUseCase.call(
      //       RequestNotParams(id: id),
      //     );
      //     response.fold(
      //       (l) {
      //         emit(ApiState<List<TaskResponse>>.failed(l.message));
      //       },
      //       (r) {
      //         emit(ApiState<List<TaskResponse>>.success(r));
      //       },
      //     );
      //   } else {
      //     emit(ApiState<List<TaskResponse>>.load());
      //     final response = await getTaskListUseCase.call(RequestNotParams());
      //     response.fold(
      //       (l) {
      //         emit(ApiState<List<TaskResponse>>.failed(l.message));
      //       },
      //       (r) {
      //         emit(ApiState<List<TaskResponse>>.success(r));
      //       },
      //     );
      //   }
//       case ChangeTaskSectionEvent(:final task):
//         if (state is SuccessState<List<TaskResponse>>) {
//           if (task != null) {
//             final updatedTasks =
//                 (state as SuccessState<List<TaskResponse>>).data;

//             final newTasks = updatedTasks.map((t) {
//               if (t.taskId.trim() == task.taskId.trim()) {
//                 return t.copyWith(
//                   status: task.status,
//                   title: task.title,
//                   date: task.date,
//                   time: task.time,
//                   recurring: task.recurring,
//                   content: task.content,
//                 );
//               }

//               return t;
//             }).toList();

//             emit(ApiState<List<TaskResponse>>.success(newTasks));
//           }
//         }

//         case ChangeTaskStatusSectionEvent(:final task, :final status):
//           if (state is SuccessState<List<TaskResponse>>) {
//             if (task != null) {
//               final updatedTasks =
//                   (state as SuccessState<List<TaskResponse>>).data;

//               final newTasks = updatedTasks.map((t) {
//                 if (t.taskId.trim() == task.taskId.trim()) {
//                   return t.copyWith(
//                   status: status,
//                   title: task.title,
//                   date: task.date,
//                   time: task.time,
//                   recurring: task.recurring,
//                   content: task.content,

//                   );
//                 }
//                 return t;
//               }).toList();

//               emit(ApiState<List<TaskResponse>>.success(newTasks));
//             }
//           }
//        case SearchTaskSectionEvent(:final search, :final status):
//             if (state is SuccessState<List<TaskResponse>>) {
//                final updatedTasks =
//                   (state as SuccessState<List<TaskResponse>>).data;
//             if (search != null  && status != null && status.isEmpty) {
             

//               final newTasks = updatedTasks.where((t) {
//                 return t.title.toLowerCase().contains(search.toLowerCase()) || t.content.toLowerCase().contains(search.toLowerCase());
//               }).toList();

//               emit(ApiState<List<TaskResponse>>.success(newTasks.isNotEmpty ? newTasks : <TaskResponse>[],refresh: true));
//             }
//              if (status != null && search != null && search.isEmpty) {

//               final newTasks = updatedTasks.where((t) {
//                 return t.status.toLowerCase().contains(status.toLowerCase());
//               }).toList();

//               emit(ApiState<List<TaskResponse>>.success(newTasks.isNotEmpty ? newTasks : <TaskResponse>[],refresh: true));
//             }
//             else{
//                final newTasks = updatedTasks.where((t) {
//                 return (t.title!.toLowerCase().contains(search!.toLowerCase()) || 
//                        t.content!.toLowerCase().contains(search!.toLowerCase()));
//               }).toList();
//               final finalTasks  = newTasks.every((t) => t.status!.toLowerCase() == status!.toLowerCase()) ? newTasks : <TaskResponse>[];

//               emit(ApiState<List<TaskResponse>>.success(finalTasks.isNotEmpty ? finalTasks : <TaskResponse>[],refresh: true));
//             }
//           }
//     }
//   }
// }


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

  /// Source de vérité : jamais filtrée.
  List<TaskResponse> _allTasks = [];

  /// Filtres courants.
  String _search = '';
  String _status = '';

  /// Applique recherche + statut sur la liste complète.
  List<TaskResponse> _applyFilter() {
    final query = _search.trim().toLowerCase();
    final st = _status.trim().toLowerCase();

    return _allTasks.where((t) {
      final matchSearch = query.isEmpty ||
          t.title.toLowerCase().contains(query) ||
          t.content.toLowerCase().contains(query);

      final matchStatus = st.isEmpty || t.status.toLowerCase() == st;

      return matchSearch && matchStatus;
    }).toList();
  }

  /// Met à jour une tâche dans la liste complète.
  List<TaskResponse> _replaceTask(TaskResponse task, {String? status}) {
    return _allTasks.map((t) {
      if (t.taskId.trim() != task.taskId.trim()) return t;
      return t.copyWith(
        status: status ?? task.status,
        title: task.title,
        date: task.date,
        time: task.time,
        recurring: task.recurring,
        content: task.content,
      );
    }).toList();
  }

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
        if (task == null) return;

        _allTasks = _replaceTask(task);
        emit(ApiState<List<TaskResponse>>.success(_applyFilter()));

      case ChangeTaskStatusSectionEvent(:final task, :final status):
        if (task == null) return;

        _allTasks = _replaceTask(task, status: status);
        emit(ApiState<List<TaskResponse>>.success(_applyFilter()));

      case SearchTaskSectionEvent(:final search, :final status):
        _search = search ?? '';
        _status = status ?? '';

        emit(ApiState<List<TaskResponse>>.success(
          _applyFilter(),
          refresh: true,
        ));
    }
  }
}

