import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:grace_church/core/data_process/success.dart';
import 'package:grace_church/core/service_systeme/error/failure.dart';
import 'package:grace_church/feature/home/data/model/home_responses_models.dart';
import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';
import 'package:grace_church/feature/taches/data/service/remote/task_remote_repository.dart';
import 'package:grace_church/feature/taches/domaine/entities/request/task_request.dart';
import 'package:grace_church/feature/taches/domaine/repositorie/task_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TaskRepository)
class TaskRepositoryImpl implements TaskRepository {
  TaskRepositoryImpl(this._remote);
  final TaskRemoteRepository _remote;

  @override
  Future<Either<Failure, List<TaskResponse>>> getTaskList(
    RequestNotParams request,
  ) async {
    final response = await _remote.getTaskList(request);
    if (response is FirebaseSuccess<List<TaskResponseModel>>) {
      log('message ---->> ${response.data}');
      return Right(response.data.map(TaskResponseModel.toDomain).toList());
    } else if (response is FirebaseError<List<TaskResponseModel>>) {
      return Left(Failure(response.message));
    }
    return Left(Failure("Erreur inconnue"));
  }
}
