import 'package:dartz/dartz.dart';
import 'package:grace_church/feature/taches/domaine/entities/request/task_request.dart';
import 'package:injectable/injectable.dart';
import 'package:grace_church/core/service_systeme/error/failure.dart';
import 'package:grace_church/core/service_systeme/usercase/usercase.dart';
import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';
import 'package:grace_church/feature/taches/domaine/repositorie/task_repository.dart';

@lazySingleton
class GetTaskListUseCase implements UseCase<List<TaskResponse>, RequestNotParams>  {
  const GetTaskListUseCase(this._repository);
  final TaskRepository _repository;

  @override
  Future<Either<Failure, List<TaskResponse>>> call(RequestNotParams request) =>
      _repository.getTaskList(request);
}