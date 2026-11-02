import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:grace_church/core/service_systeme/error/failure.dart';
import 'package:grace_church/core/alarme_notification/domaine/repositorie/permission_notification_repository.dart';

/// Implémentation du contrat [PermissionNotificationRepository] via
/// `permission_handler` (déjà présente dans le projet).
@LazySingleton(as: PermissionNotificationRepository)
class PermissionNotificationRepositoryImpl
    implements PermissionNotificationRepository {
  @override
  Future<Either<Failure, EtatPermission>> verifier() async {
    try {
      final notifications = await Permission.notification.status;
      final alarmes = await Permission.scheduleExactAlarm.status;
      return right(
        EtatPermission(
          notifications: notifications.isGranted,
          alarmesExactes: alarmes.isGranted,
        ),
      );
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, EtatPermission>> demander() async {
    try {
      // Demande combinée : notifications + alarmes exactes.
      final resultats = await [
        Permission.notification,
        Permission.scheduleExactAlarm,
      ].request();

      final notifications = resultats[Permission.notification]?.isGranted ?? false;
      final alarmes = resultats[Permission.scheduleExactAlarm]?.isGranted ?? false;

      return right(
        EtatPermission(
          notifications: notifications,
          alarmesExactes: alarmes,
        ),
      );
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> ouvrirReglages() async {
    try {
      final ouvert = await openAppSettings();
      return ouvert ? right(unit) : left(const Failure('Impossible d\'ouvrir les réglages'));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
