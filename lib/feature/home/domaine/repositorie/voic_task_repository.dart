import 'package:dartz/dartz.dart';
import 'package:to_doia/core/service_systeme/error/failure.dart';
import 'package:to_doia/feature/home/domaine/entities/response/home_responses.dart';

abstract class VoiceTaskRepository {
  Future<Either<Failure, TaskResponse>> createTaskFromVoice(String audioPath);
}
