// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_database/firebase_database.dart' as _i345;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../feature/auth/data/repository/auth_repository_impl.dart' as _i648;
import '../../feature/auth/domaine/repositorie/auth_repository.dart' as _i659;
import '../../feature/auth/domaine/usecase/connecter_utilisateur_usecase.dart'
    as _i835;
import '../../feature/auth/domaine/usecase/deconnecter_utilisateur_usecase.dart'
    as _i249;
import '../../feature/auth/domaine/usecase/inscrire_utilisateur_usecase.dart'
    as _i731;
import '../../feature/auth/domaine/usecase/surveiller_utilisateur_usecase.dart'
    as _i501;
import '../../feature/auth/domaine/usecase/utilisateur_courant_usecase.dart'
    as _i150;
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
import '../../feature/home/domaine/usecase/shara_navigation_usecase.dart'
    as _i174;
import '../../feature/home/domaine/usecase/update_task_from_usercase.dart'
    as _i49;
import '../../feature/setting/data/repository/feedback_repository_impl.dart'
    as _i689;
import '../../feature/setting/domaine/repositorie/feedback_repository.dart'
    as _i382;
import '../../feature/setting/domaine/usecase/envoyer_feedback_usecase.dart'
    as _i596;
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
import '../alarme_notification/data/repository/alarme_repository_impl.dart'
    as _i702;
import '../alarme_notification/data/repository/notification_repository_impl.dart'
    as _i569;
import '../alarme_notification/data/repository/permission_notification_repository_impl.dart'
    as _i933;
import '../alarme_notification/data/service/local/alarme_persistance_service.dart'
    as _i805;
import '../alarme_notification/data/service/notification_local_service.dart'
    as _i755;
import '../alarme_notification/domaine/repositorie/alarme_repository.dart'
    as _i966;
import '../alarme_notification/domaine/repositorie/notification_repository.dart'
    as _i184;
import '../alarme_notification/domaine/repositorie/permission_notification_repository.dart'
    as _i16;
import '../alarme_notification/domaine/task_reminder_manager.dart' as _i75;
import '../alarme_notification/domaine/usecase/gerer_notifications_usecase.dart'
    as _i567;
import '../alarme_notification/domaine/usecase/gerer_permission_notification_usecase.dart'
    as _i253;
import '../alarme_notification/domaine/usecase/programmer_alarme_usecase.dart'
    as _i711;
import '../alarme_notification/service/alarme_notification_service.dart'
    as _i565;
import 'injection_container.dart' as _i809;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final injectableModule = _$InjectableModule();
    gh.lazySingleton<_i755.NotificationLocalService>(
      () => _i755.NotificationLocalService(),
    );
    gh.lazySingleton<_i345.DatabaseReference>(() => injectableModule.userDb);
    gh.lazySingleton<_i974.FirebaseFirestore>(() => injectableModule.firestore);
    gh.lazySingleton<_i59.FirebaseAuth>(() => injectableModule.firebaseAuth);
    gh.lazySingleton<_i519.Client>(() => injectableModule.httpClient);
    gh.lazySingleton<_i558.FlutterSecureStorage>(() => injectableModule.prefs);
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => injectableModule.locaDataShared(),
      preResolve: true,
    );
    gh.lazySingleton<_i659.AuthRepository>(
      () => _i648.AuthRepositoryImpl(
        gh<_i59.FirebaseAuth>(),
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i16.PermissionNotificationRepository>(
      () => _i933.PermissionNotificationRepositoryImpl(),
    );
    gh.lazySingleton<_i763.TaskRemoteRepository>(
      () => _i963.TaskRemoteRepositoryImpl(db: gh<_i345.DatabaseReference>()),
    );
    gh.lazySingleton<_i348.HomeRemoteRepository>(
      () => _i386.HomeRemoteRepositoryImpl(db: gh<_i345.DatabaseReference>()),
    );
    gh.lazySingleton<_i253.GererPermissionsNotificationUseCase>(
      () => _i253.GererPermissionsNotificationUseCase(
        gh<_i16.PermissionNotificationRepository>(),
      ),
    );
    gh.lazySingleton<_i805.AlarmePersistanceService>(
      () => _i805.AlarmePersistanceService(gh<_i460.SharedPreferences>()),
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
    gh.lazySingleton<_i49.UpdateTaskUseCase>(
      () => _i49.UpdateTaskUseCase(gh<_i282.HomeRepository>()),
    );
    gh.lazySingleton<_i382.FeedbackRepository>(
      () => _i689.FeedbackRepositoryImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i184.NotificationRepository>(
      () => _i569.NotificationRepositoryImpl(
        gh<_i755.NotificationLocalService>(),
      ),
    );
    gh.lazySingleton<_i835.ConnecterUtilisateurUseCase>(
      () => _i835.ConnecterUtilisateurUseCase(gh<_i659.AuthRepository>()),
    );
    gh.lazySingleton<_i249.DeconnecterUtilisateurUseCase>(
      () => _i249.DeconnecterUtilisateurUseCase(gh<_i659.AuthRepository>()),
    );
    gh.lazySingleton<_i731.InscrireUtilisateurUseCase>(
      () => _i731.InscrireUtilisateurUseCase(gh<_i659.AuthRepository>()),
    );
    gh.lazySingleton<_i501.SurveillerUtilisateurUseCase>(
      () => _i501.SurveillerUtilisateurUseCase(gh<_i659.AuthRepository>()),
    );
    gh.lazySingleton<_i150.UtilisateurCourantUseCase>(
      () => _i150.UtilisateurCourantUseCase(gh<_i659.AuthRepository>()),
    );
    gh.lazySingleton<_i1062.TaskRepository>(
      () => _i321.TaskRepositoryImpl(gh<_i763.TaskRemoteRepository>()),
    );
    gh.lazySingleton<_i596.EnvoyerFeedbackUseCase>(
      () => _i596.EnvoyerFeedbackUseCase(gh<_i382.FeedbackRepository>()),
    );
    gh.lazySingleton<_i966.AlarmeRepository>(
      () => _i702.AlarmeRepositoryImpl(
        gh<_i755.NotificationLocalService>(),
        gh<_i805.AlarmePersistanceService>(),
      ),
    );
    gh.lazySingleton<_i567.GererNotificationsUseCase>(
      () => _i567.GererNotificationsUseCase(gh<_i184.NotificationRepository>()),
    );
    gh.lazySingleton<_i75.TaskReminderManager>(
      () => _i75.TaskReminderManager(gh<_i966.AlarmeRepository>()),
    );
    gh.lazySingleton<_i711.ProgrammerAlarmeUseCase>(
      () => _i711.ProgrammerAlarmeUseCase(gh<_i966.AlarmeRepository>()),
    );
    gh.lazySingleton<_i722.VoiceTaskRepository>(
      () => _i681.VoiceTaskRepositoryImpl(gh<_i78.GroqRemoteDataSource>()),
    );
    gh.lazySingleton<_i767.GetTaskListUseCase>(
      () => _i767.GetTaskListUseCase(gh<_i1062.TaskRepository>()),
    );
    gh.lazySingleton<_i565.AlarmeNotificationService>(
      () => _i565.AlarmeNotificationService(
        gh<_i755.NotificationLocalService>(),
        gh<_i805.AlarmePersistanceService>(),
      ),
    );
    gh.lazySingleton<_i439.GetListBloc>(
      () => _i439.GetListBloc(
        getTaskListUseCase: gh<_i767.GetTaskListUseCase>(),
        surveillerUtilisateurUseCase: gh<_i501.SurveillerUtilisateurUseCase>(),
        taskReminder: gh<_i75.TaskReminderManager>(),
      ),
    );
    gh.lazySingleton<_i324.CreateTaskFromVoiceUseCase>(
      () => _i324.CreateTaskFromVoiceUseCase(gh<_i722.VoiceTaskRepository>()),
    );
    gh.lazySingleton<_i174.SharaNavigationUsecase>(
      () => _i174.SharaNavigationUsecase(gh<_i722.VoiceTaskRepository>()),
    );
    gh.lazySingleton<_i174.SharaInteractUsecase>(
      () => _i174.SharaInteractUsecase(gh<_i722.VoiceTaskRepository>()),
    );
    return this;
  }
}

class _$InjectableModule extends _i809.InjectableModule {}
