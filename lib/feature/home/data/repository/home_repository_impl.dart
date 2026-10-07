import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:grace_church/core/data_process/success.dart';
import 'package:grace_church/core/service_systeme/error/failure.dart';
import 'package:grace_church/feature/home/data/service/remote/home_remote_repository.dart';
import 'package:grace_church/feature/home/domaine/entities/request/home_request.dart';
import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';
import 'package:grace_church/feature/home/domaine/repositorie/home_repository.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this._remote);
  final HomeRemoteRepository _remote;

  @override
  Future<Either<Failure, TaskResponse>> createTaskFromVoice({
    required String audioPath,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String?>> createTask(RequestCreateTask request) async {
    final response = await _remote.createTask(request);
    if (response is FirebaseSuccess<String?>) {
      return Right(response.data);
    } else if (response is FirebaseError<String?>) {
      return Left(Failure(response.message));
    }
    return Left(Failure("Erreur inconnue"));
  }

  @override
  Future<Either<Failure, String?>> updateTask(RequestCreateTask request) async {
    final response = await _remote.updateTask(request);
    if (response is FirebaseSuccess<String?>) {
      return Right(response.data);
    } else if (response is FirebaseError<String?>) {
      return Left(Failure(response.message));
    }
    return Left(Failure("Erreur inconnue"));
  }
}
