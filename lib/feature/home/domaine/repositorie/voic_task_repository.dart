import 'package:dartz/dartz.dart';
import 'package:grace_church/core/service_systeme/error/failure.dart';
import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';

abstract class VoiceTaskRepository {
  Future<Either<Failure, TaskResponse>> createTaskFromVoice(String audioPath);
}
