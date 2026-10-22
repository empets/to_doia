import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:grace_church/core/service_systeme/error/failure.dart';
import 'package:grace_church/core/service_systeme/usercase/usercase.dart';
import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';
import 'package:grace_church/feature/home/domaine/repositorie/voic_task_repository.dart';

@lazySingleton
class SharaNavigationUsecase implements UseCase<GraceResponse, List<Map<String, String>>>  {
  const SharaNavigationUsecase(this._repository);
  final VoiceTaskRepository _repository;

  @override
  Future<Either<Failure, GraceResponse>> call(List<Map<String, String>> messages) =>
      _repository.chat(messages);
}