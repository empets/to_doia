import 'package:dartz/dartz.dart';
import 'package:grace_church/core/service_systeme/error/failure.dart';
import 'package:grace_church/core/service_systeme/usercase/usercase.dart';
import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';
import 'package:grace_church/feature/home/domaine/repositorie/voic_task_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SharaNavigationUsecase
    implements UseCase<GraceResponse, List<Map<String, String>>> {
  const SharaNavigationUsecase(this._repository);
  final VoiceTaskRepository _repository;

  @override
  Future<Either<Failure, GraceResponse>> call(
    List<Map<String, String>> messages,
  ) => _repository.chat(messages);
}

@lazySingleton
class SharaInteractUsecase
    implements UseCase<SharaResponse, Map<String, dynamic>> {
  const SharaInteractUsecase(this._repository);
  final VoiceTaskRepository _repository;




  @override
  Future<Either<Failure, SharaResponse>> call(Map<String, dynamic> params) =>
      _repository.interact(
        audioPath: params['audioPath'] as String,
        history: params['history'] as List<Map<String, String>>,
        recordTime: params['recordTime'] as int,
      );
}
