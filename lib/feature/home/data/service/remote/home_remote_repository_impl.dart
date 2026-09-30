import 'package:to_doia/core/service_systeme/model/api/api_result.dart';
import 'package:to_doia/feature/home/data/home_responses_models.dart';
import 'package:to_doia/feature/home/data/service/remote/home_remote_repository.dart';
import 'package:injectable/injectable.dart';


@LazySingleton(as: HomeRemoteRepository)
class HomeRemoteRepositoryImpl implements HomeRemoteRepository {
  




  @override
  Future<ApiResult<TaskResponseModel>> createTaskFromVoice({required String audioPath}) {
    // TODO: implement createTaskFromVoice
    throw UnimplementedError();
  }
}
