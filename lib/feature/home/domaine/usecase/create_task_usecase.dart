import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:grace_church/core/service_systeme/error/failure.dart';
import 'package:grace_church/core/service_systeme/usercase/usercase.dart';
import 'package:grace_church/feature/home/domaine/entities/request/home_request.dart';
import 'package:grace_church/feature/home/domaine/repositorie/home_repository.dart';

@lazySingleton
class CreateTaskUseCase implements UseCase<String?, RequestCreateTask>  {
  const CreateTaskUseCase(this._repository);
  final HomeRepository _repository;

  @override
  Future<Either<Failure, String?>> call(RequestCreateTask request) =>
      _repository.createTask(request);
}