import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:grace_church/core/service_systeme/error/failure.dart';
import 'package:grace_church/core/alarme_notification/domaine/entities/notification_programmee_entite.dart';
import 'package:grace_church/core/alarme_notification/domaine/repositorie/notification_repository.dart';
import 'programmer_alarme_usecase.dart';

/// UseCase : applique l'ensemble des opérations de notification du module
/// (affichage immédiat, programmation, annulation, cycle de vie).
///
/// Un seul usecase regroupe les 6 opérations car elles partagent le même
/// cycle de vie et sont quasi toujours utilisées ensemble par les BLoCs.
@lazySingleton
class GererNotificationsUseCase
    extends UseCaseBase<Unit, GererNotificationsParams> {
  GererNotificationsUseCase(this._repository);

  final NotificationRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(GererNotificationsParams params) {
    switch (params.typeOperation) {
      case OperationNotification.afficher:
        return _repository.afficher(params.notification!);
      case OperationNotification.programmer:
        return _repository.programmer(params.notification!);
      case OperationNotification.annuler:
        return _repository.annuler(params.id!);
      case OperationNotification.initialiser:
        return _repository.initialiser();
      case OperationNotification.arreter:
        return _repository.arreter();
      case OperationNotification.toutAnnuler:
        return _repository.toutAnnuler();
    }
  }
}

/// Opérations supportées par [GererNotificationsUseCase].
enum OperationNotification {
  afficher,
  programmer,
  annuler,
  initialiser,
  arreter,
  toutAnnuler,
}

/// Paramètres de [GererNotificationsUseCase] :
/// - afficher / programmer → [notification] obligatoire
/// - annuler → [id] obligatoire
/// - initialiser / arreter / toutAnnuler → rien d'obligatoire
class GererNotificationsParams extends Equatable {
  const GererNotificationsParams({
    required this.typeOperation,
    this.notification,
    this.id,
  });

  final OperationNotification typeOperation;
  final NotificationProgrammeeEntite? notification;
  final int? id;

  @override
  List<Object?> get props => [typeOperation, notification, id];
}
