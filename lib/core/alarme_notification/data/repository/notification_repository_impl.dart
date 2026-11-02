import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:grace_church/core/service_systeme/error/failure.dart';
import 'package:grace_church/core/alarme_notification/domaine/entities/notification_programmee_entite.dart';
import 'package:grace_church/core/alarme_notification/domaine/repositorie/notification_repository.dart';
import 'package:grace_church/core/alarme_notification/data/service/notification_local_service.dart';

/// Implémentation du contrat [NotificationRepository] :
/// notifications locales, programmées, et cycle de vie du service.
@LazySingleton(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  NotificationRepositoryImpl(this._service);

  final NotificationLocalService _service;

  @override
  Future<Either<Failure, Unit>> initialiser() async {
    try {
      await _service.initialiser();
      return right(unit);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> arreter() async {
    try {
      await _service.arreter();
      return right(unit);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> afficher(
    NotificationProgrammeeEntite notif,
  ) async {
    try {
      await _service.afficher(
        notif.id,
        notif.titre,
        notif.corps,
        canal: notif.canalId,
        payload: notif.payload,
      );
      return right(unit);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> programmer(
    NotificationProgrammeeEntite notif,
  ) async {
    try {
      await _service.programmer(
        notif.id,
        notif.titre,
        notif.corps,
        notif.dateHeure,
        canal: notif.canalId,
        payload: notif.payload,
      );
      return right(unit);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> annuler(int idNotification) async {
    try {
      await _service.annuler(idNotification);
      return right(unit);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<int>>> programmeeEnAttente() async {
    try {
      final enAttente = await _service.enAttente();
      return right(enAttente.map((n) => n.id).toList());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> toutAnnuler() async {
    try {
      await _service.toutAnnuler();
      return right(unit);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
