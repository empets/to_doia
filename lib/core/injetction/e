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

import '../../feature/authen/data/repositories/imple_repositories.dart'
    as _i598;
import '../../feature/authen/data/service/impl_remote_service.dart' as _i259;
import '../../feature/authen/data/service/remote_service.dart' as _i166;
import '../../feature/authen/domaine/repository/authen_repository.dart'
    as _i653;
import '../../feature/authen/domaine/usercase/connexion_implicite_usercase.dart'
    as _i16;
import '../../feature/authen/domaine/usercase/create_profile_engagement.dart'
    as _i1031;
import '../../feature/authen/domaine/usercase/create_profile_usercase.dart'
    as _i855;
import '../../feature/authen/domaine/usercase/create_social_profile_usercase.dart'
    as _i561;
import '../../feature/authen/domaine/usercase/create_spiritual_profile.dart'
    as _i127;
import '../../feature/authen/domaine/usercase/signin_profile.dart' as _i409;
import '../../feature/authen/domaine/usercase/update_profile_deviceid_usercase.dart'
    as _i240;
import '../../feature/authen/domaine/usercase/update_profile_usercase.dart'
    as _i256;
import '../../feature/depatement/cellule/data/repositories/cellule_imple_repositories.dart'
    as _i389;
import '../../feature/depatement/cellule/data/services/celllule_repositories_remote_services.dart'
    as _i87;
import '../../feature/depatement/cellule/data/services/cellule_imple_repositories_remot_services.dart'
    as _i277;
import '../../feature/depatement/cellule/domaine/repositories/cellule_repositories_domaine.dart'
    as _i521;
import '../../feature/depatement/cellule/domaine/usecase/get_cellule_usercase.dart'
    as _i56;
import '../../feature/depatement/cellule/domaine/usecase/get_list_responsable_cellule_usercase.dart'
    as _i702;
import '../../feature/depatement/cellule/domaine/usecase/get_list_secteur.dart'
    as _i643;
import '../../feature/depatement/cellule/domaine/usecase/get_list_zone.dart'
    as _i448;
import '../../feature/depatement/cellule/domaine/usecase/get_rapport_cellule_usercase.dart'
    as _i577;
import '../../feature/depatement/cellule/domaine/usecase/rapport_cellule_admine_usercase.dart'
    as _i444;
import '../../feature/depatement/cellule/domaine/usecase/rapport_cellule_stat_usercase.dart'
    as _i238;
import '../../feature/depatement/cellule/domaine/usecase/rapport_cellule_state_usercase.dart'
    as _i578;
import '../../feature/depatement/cellule/domaine/usecase/rapport_cellule_suggestion_usercase.dart'
    as _i8;
import '../../feature/depatement/cellule/presentation/bloc/cellule_bloc.dart'
    as _i323;
import '../../feature/depatement/cellule/presentation/bloc/get_responsable_cellue_bloc.dart'
    as _i22;
import '../../feature/depatement/cellule/presentation/bloc/get_responsable_secteur.dart'
    as _i868;
import '../../feature/depatement/cellule/presentation/bloc/get_responsable_zone.dart'
    as _i352;
import '../../feature/depatement/cellule/presentation/bloc/rapport_cellule.dart/get_rapport_cellule_bloc.dart'
    as _i702;
import '../../feature/home/data/repositories/home_data_repositories.dart'
    as _i486;
import '../../feature/home/data/service/remot_service.dart' as _i127;
import '../../feature/home/data/service/repository_remote_service.dart' as _i61;
import '../../feature/home/data/service/steam_remote_service.dart' as _i366;
import '../../feature/home/domaine/repository/home_domain_repository.dart'
    as _i962;
import '../../feature/home/domaine/usercase/get_profile_usercase.dart' as _i562;
import '../../feature/home/page/bloc/app_launcher/app_launcher_bloc.dart'
    as _i303;
import '../../feature/home/page/bloc/get_profile/get_profile_bloc.dart' as _i37;
import '../../feature/notification/data/repositories/impl_notification_repositories.dart'
    as _i236;
import '../../feature/notification/data/services/notification_imple_repositories_remote_service.dart'
    as _i340;
import '../../feature/notification/data/services/notification_repositorie_remot_service.dart'
    as _i374;
import '../../feature/notification/domaine/repositories/i_notification_repositories.dart'
    as _i482;
import '../../feature/notification/domaine/usecase/get_list_notification_usercase.dart'
    as _i249;
import '../../feature/notification/domaine/usecase/get_noftification_list_by_criterya.dart'
    as _i554;
import '../../feature/notification/domaine/usecase/read_notification_usercase.dart'
    as _i260;
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
    gh.lazySingleton<_i366.ImpleSteamRemoteService>(
      () => _i366.ImpleSteamRemoteService(),
    );
    gh.lazySingleton<_i303.AppLauncherBloc>(() => _i303.AppLauncherBloc());
    gh.lazySingleton<_i259.AuthenRemoteService>(
      () => _i166.ImplRemoteService(db: gh<_i345.DatabaseReference>()),
    );
    gh.lazySingleton<_i61.DomaineServiceRepository>(
      () =>
          _i127.ImpDomaineServiceRepository(db: gh<_i345.DatabaseReference>()),
    );
    gh.lazySingleton<_i374.NotificationRepositorieRemotService>(
      () => _i340.NotificationImpleRepositoriesRemoteService(
        db: gh<_i345.DatabaseReference>(),
      ),
    );
    gh.lazySingleton<_i87.CellluleRepositoriesRemoteServices>(
      () => _i277.CelluleImpleRepositoriesRemotServices(
        db: gh<_i345.DatabaseReference>(),
      ),
    );
    gh.lazySingleton<_i962.HomeDomaineRepository>(
      () => _i486.ImpleHomeDataRepositories(
        domaineServiceRepository: gh<_i61.DomaineServiceRepository>(),
      ),
    );
    gh.lazySingleton<_i653.AuthenRepository>(
      () => _i598.ImpleAuthenRepository(
        authenRemoteService: gh<_i259.AuthenRemoteService>(),
      ),
    );
    gh.lazySingleton<_i521.CelluleRepositoriesDomaine>(
      () => _i389.CelluleImpleRepositories(
        cellluleRepositoriesRemoteServices:
            gh<_i87.CellluleRepositoriesRemoteServices>(),
      ),
    );
    gh.lazySingleton<_i56.GetCelluleUsercase>(
      () => _i56.GetCelluleUsercase(gh<_i521.CelluleRepositoriesDomaine>()),
    );
    gh.lazySingleton<_i702.GetListResponsableCelluleUsercase>(
      () => _i702.GetListResponsableCelluleUsercase(
        gh<_i521.CelluleRepositoriesDomaine>(),
      ),
    );
    gh.lazySingleton<_i643.GetListSecteurUsercase>(
      () =>
          _i643.GetListSecteurUsercase(gh<_i521.CelluleRepositoriesDomaine>()),
    );
    gh.lazySingleton<_i448.GetListZoneUsercase>(
      () => _i448.GetListZoneUsercase(gh<_i521.CelluleRepositoriesDomaine>()),
    );
    gh.lazySingleton<_i577.GetRapportCelluleUsercase>(
      () => _i577.GetRapportCelluleUsercase(
        gh<_i521.CelluleRepositoriesDomaine>(),
      ),
    );
    gh.lazySingleton<_i444.SendRapportCelluleStepAdministrationUsercase>(
      () => _i444.SendRapportCelluleStepAdministrationUsercase(
        gh<_i521.CelluleRepositoriesDomaine>(),
      ),
    );
    gh.lazySingleton<_i238.SendRapportCelluleStepStatUsercase>(
      () => _i238.SendRapportCelluleStepStatUsercase(
        gh<_i521.CelluleRepositoriesDomaine>(),
      ),
    );
    gh.lazySingleton<_i578.SendRapportCelluleStepAssistantUsercase>(
      () => _i578.SendRapportCelluleStepAssistantUsercase(
        gh<_i521.CelluleRepositoriesDomaine>(),
      ),
    );
    gh.lazySingleton<_i8.SendRapportCelluleStepSuggestionUsercase>(
      () => _i8.SendRapportCelluleStepSuggestionUsercase(
        gh<_i521.CelluleRepositoriesDomaine>(),
      ),
    );
    gh.lazySingleton<_i868.GetSecteurBloc>(
      () => _i868.GetSecteurBloc(
        getListSecteurUsercase: gh<_i643.GetListSecteurUsercase>(),
      ),
    );
    gh.lazySingleton<_i482.NotificationDomaineRepositories>(
      () => _i236.ImplNotificationRepositories(
        notificationRepositorieRemotService:
            gh<_i374.NotificationRepositorieRemotService>(),
      ),
    );
    gh.lazySingleton<_i323.CelluleBloc>(
      () =>
          _i323.CelluleBloc(getCelluleUsercase: gh<_i56.GetCelluleUsercase>()),
    );
    gh.lazySingleton<_i22.GetResponsableCelluleBloc>(
      () => _i22.GetResponsableCelluleBloc(
        getListResponsableCelluleUsercase:
            gh<_i702.GetListResponsableCelluleUsercase>(),
      ),
    );
    gh.lazySingleton<_i562.GetProfileUsercase>(
      () => _i562.GetProfileUsercase(gh<_i962.HomeDomaineRepository>()),
    );
    gh.lazySingleton<_i249.GetListNotificationUsercase>(
      () => _i249.GetListNotificationUsercase(
        gh<_i482.NotificationDomaineRepositories>(),
      ),
    );
    gh.lazySingleton<_i554.GetListNotificationByCriteriaUsercase>(
      () => _i554.GetListNotificationByCriteriaUsercase(
        gh<_i482.NotificationDomaineRepositories>(),
      ),
    );
    gh.lazySingleton<_i260.ReadNotificationUsercase>(
      () => _i260.ReadNotificationUsercase(
        gh<_i482.NotificationDomaineRepositories>(),
      ),
    );
    gh.lazySingleton<_i16.GetConnexionImpliciteUsercase>(
      () => _i16.GetConnexionImpliciteUsercase(gh<_i653.AuthenRepository>()),
    );
    gh.lazySingleton<_i1031.CreateEngagementProfileUsercase>(
      () =>
          _i1031.CreateEngagementProfileUsercase(gh<_i653.AuthenRepository>()),
    );
    gh.lazySingleton<_i855.CreateProfileUsercase>(
      () => _i855.CreateProfileUsercase(gh<_i653.AuthenRepository>()),
    );
    gh.lazySingleton<_i561.CreateSocialProfileUsercase>(
      () => _i561.CreateSocialProfileUsercase(gh<_i653.AuthenRepository>()),
    );
    gh.lazySingleton<_i127.CreateSpiritualProfileUsercase>(
      () => _i127.CreateSpiritualProfileUsercase(gh<_i653.AuthenRepository>()),
    );
    gh.lazySingleton<_i409.CreateSignInProfileUsercase>(
      () => _i409.CreateSignInProfileUsercase(gh<_i653.AuthenRepository>()),
    );
    gh.lazySingleton<_i240.UpdateProfileDeviceIdUsercase>(
      () => _i240.UpdateProfileDeviceIdUsercase(gh<_i653.AuthenRepository>()),
    );
    gh.lazySingleton<_i256.UpdateProfileUsercase>(
      () => _i256.UpdateProfileUsercase(gh<_i653.AuthenRepository>()),
    );
    gh.lazySingleton<_i303.ConnexionImpliciteBloc>(
      () => _i303.ConnexionImpliciteBloc(
        getConnexionImpliciteUsercase: gh<_i16.GetConnexionImpliciteUsercase>(),
      ),
    );
    gh.lazySingleton<_i352.GetZoneBloc>(
      () => _i352.GetZoneBloc(
        getListZoneUsercase: gh<_i448.GetListZoneUsercase>(),
      ),
    );
    gh.lazySingleton<_i702.GetRapportCelluleBloc>(
      () => _i702.GetRapportCelluleBloc(
        getRapportCelluleUsercase: gh<_i577.GetRapportCelluleUsercase>(),
      ),
    );
    gh.lazySingleton<_i37.GetProfileBloc>(
      () => _i37.GetProfileBloc(
        getProfileUsercase: gh<_i562.GetProfileUsercase>(),
      ),
    );
    return this;
  }
}

class _$InjectableModule extends _i809.InjectableModule {}
