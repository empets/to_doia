import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:grace_church/core/service_systeme/error/failure.dart';
import 'package:injectable/injectable.dart';

import 'package:grace_church/core/alarme_notification/domaine/repositorie/permission_notification_repository.dart';
import 'programmer_alarme_usecase.dart';

/// UseCase : vérifie (et, si [demander] est vrai, demande) les permissions
/// nécessaires aux alarmes et notifications.
@lazySingleton
class GererPermissionsNotificationUseCase
    extends UseCaseBase<EtatPermission, GererPermissionsNotificationParams> {
  GererPermissionsNotificationUseCase(this._repository);

  final PermissionNotificationRepository _repository;

  @override
  Future<Either<Failure, EtatPermission>> call(
    GererPermissionsNotificationParams params,
  ) => params.demander ? _repository.demander() : _repository.verifier();
}

class GererPermissionsNotificationParams extends Equatable {
  const GererPermissionsNotificationParams({this.demander = false});

  /// Si vrai, on demande la permission (au lieu de seulement la vérifier).
  final bool demander;

  @override
  List<Object?> get props => [demander];
}
