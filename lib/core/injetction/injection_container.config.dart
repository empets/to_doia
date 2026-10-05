// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:firebase_database/firebase_database.dart' as _i345;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../feature/home/data/repository/home_repository_impl.dart' as _i435;
import '../../feature/home/data/repository/voice_task_repository_impl.dart'
    as _i681;
import '../../feature/home/data/service/remote/groq_remote_data_soucre.dart'
    as _i78;
import '../../feature/home/data/service/remote/home_remote_repository.dart'
    as _i348;
import '../../feature/home/data/service/remote/home_remote_repository_impl.dart'
    as _i386;
import '../../feature/home/domaine/repositorie/home_repository.dart' as _i282;
import '../../feature/home/domaine/repositorie/voic_task_repository.dart'
    as _i722;
import '../../feature/home/domaine/usecase/create_task_from_voice.dart'
    as _i324;
import '../../feature/home/domaine/usecase/create_task_usecase.dart' as _i320;
import '../../feature/taches/data/repository/home_repository_impl.dart'
    as _i321;
import '../../feature/taches/data/service/remote/task_remote_repository.dart'
    as _i763;
import '../../feature/taches/data/service/remote/task_remote_repository_impl.dart'
    as _i963;
import '../../feature/taches/domaine/repositorie/task_repository.dart'
    as _i1062;
import '../../feature/taches/domaine/usecase/get_task_list_usecase.dart'
    as _i767;
import '../../feature/taches/presentation/bloc/get_task/get_list_bloc.dart'
    as _i439;
import 'injection_container.dart' as _i809;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final injectableModule = _$InjectableModule();
    gh.lazySingleton<_i345.DatabaseReference>(() => injectableModule.userDb);
    gh.lazySingleton<_i519.Client>(() => injectableModule.httpClient);
    gh.lazySingleton<_i558.FlutterSecureStorage>(() => injectableModule.prefs);
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => injectableModule.locaDataShared(),
      preResolve: true,
    );
    gh.lazySingleton<_i763.TaskRemoteRepository>(
      () => _i963.TaskRemoteRepositoryImpl(db: gh<_i345.DatabaseReference>()),
    );
    gh.lazySingleton<_i348.HomeRemoteRepository>(
      () => _i386.HomeRemoteRepositoryImpl(db: gh<_i345.DatabaseReference>()),
    );
    gh.lazySingleton<_i282.HomeRepository>(
      () => _i435.HomeRepositoryImpl(gh<_i348.HomeRemoteRepository>()),
    );
    gh.lazySingleton<_i78.GroqRemoteDataSource>(
      () => _i78.GroqRemoteDataSourceImpl(gh<_i519.Client>()),
    );
    gh.lazySingleton<_i320.CreateTaskUseCase>(
      () => _i320.CreateTaskUseCase(gh<_i282.HomeRepository>()),
    );
    gh.lazySingleton<_i1062.TaskRepository>(
      () => _i321.TaskRepositoryImpl(gh<_i763.TaskRemoteRepository>()),
    );
    gh.lazySingleton<_i722.VoiceTaskRepository>(
      () => _i681.VoiceTaskRepositoryImpl(gh<_i78.GroqRemoteDataSource>()),
    );
    gh.lazySingleton<_i767.GetTaskListUseCase>(
      () => _i767.GetTaskListUseCase(gh<_i1062.TaskRepository>()),
    );
    gh.lazySingleton<_i324.CreateTaskFromVoiceUseCase>(
      () => _i324.CreateTaskFromVoiceUseCase(gh<_i722.VoiceTaskRepository>()),
    );
    gh.lazySingleton<_i439.GetListBloc>(
      () =>
          _i439.GetListBloc(getTaskListUseCase: gh<_i767.GetTaskListUseCase>()),
    );
    return this;
  }
}

class _$InjectableModule extends _i809.InjectableModule {}
