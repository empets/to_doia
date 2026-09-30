
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:to_doia/core/service_systeme/error/failure.dart';
import 'package:to_doia/feature/home/domaine/entities/response/home_responses.dart';
import 'package:to_doia/feature/home/domaine/repositorie/home_repository.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<Either<Failure, TaskResponse>> createTaskFromVoice({required String audioPath}) {
    throw UnimplementedError();
  }
}
