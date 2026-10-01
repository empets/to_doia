import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:to_doia/core/service_systeme/error/failure.dart';
import 'package:to_doia/core/service_systeme/usercase/usercase.dart';
import 'package:to_doia/feature/home/domaine/entities/response/home_responses.dart';
import 'package:to_doia/feature/home/domaine/repositorie/voic_task_repository.dart';

@lazySingleton
class CreateTaskFromVoiceUseCase implements UseCase<TaskResponse, String>  {
  const CreateTaskFromVoiceUseCase(this._repository);
  final VoiceTaskRepository _repository;

  @override
  Future<Either<Failure, TaskResponse>> call(String audioPath) =>
      _repository.createTaskFromVoice(audioPath);
}