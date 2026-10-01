import 'dart:async';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:to_doia/core/service_systeme/error/failure.dart';
import 'package:to_doia/feature/home/data/model/home_responses_models.dart';
import 'package:to_doia/feature/home/data/service/remote/groq_remote_data_soucre.dart';
import 'package:to_doia/feature/home/domaine/entities/response/home_responses.dart';
import 'package:to_doia/feature/home/domaine/repositorie/voic_task_repository.dart';


@LazySingleton(as: VoiceTaskRepository)
class VoiceTaskRepositoryImpl implements VoiceTaskRepository {
  const VoiceTaskRepositoryImpl(this._remote);
  final GroqRemoteDataSource _remote;

  @override
  Future<Either<Failure, TaskResponse>> createTaskFromVoice(
    String audioPath,
  ) async {
    try {
      final transcript = await _remote.transcribe(audioPath);
      final model = await _remote.extractTask(transcript);
      return Right(
        TaskResponseModel.toDomain(model),
      );
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    } on SocketException {
      return const Left(Failure('Pas de connexion internet'));
    } on TimeoutException {
      return const Left(Failure('Délai dépassé, réessaie'));
    } on FormatException {
      return const Left(Failure('Réponse invalide du serveur'));
    }
  }
}