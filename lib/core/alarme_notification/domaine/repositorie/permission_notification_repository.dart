import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:grace_church/core/service_systeme/error/failure.dart';

/// Contrat (couche domaine) : permissions nécessaires aux alarmes et
/// notifications, pour Android (POST_NOTIFICATIONS, SCHEDULE_EXACT_ALARM,
/// exact alarms) et iOS (autorisation alert/banner/sound/badge).
abstract class PermissionNotificationRepository {
  /// État courant des permissions. Voir [EtatPermission].
  Future<Either<Failure, EtatPermission>> verifier();

  /// Demande à l'utilisateur d'accorder les permissions manquantes.
  /// Retourne l'état APRÈS la réponse de l'utilisateur.
  Future<Either<Failure, EtatPermission>> demander();

  /// Ouvre les réglages système de l'application (si refus définitif).
  Future<Either<Failure, Unit>> ouvrirReglages();
}

/// État consolidé des permissions liées aux alarmes / notifications.
class EtatPermission extends Equatable {
  const EtatPermission({this.notifications = false, this.alarmesExactes = false, this.reglagesOuverts = false});

  /// L'app peut afficher des notifications système.
  final bool notifications;

  /// L'app peut programmer des alarmes exactes (Android 12+ : SCHEDULE_EXACT_ALARM).
  /// Sur iOS, ce droit n'existe pas → toujours `true`.
  final bool alarmesExactes;

  /// Vrai si la dernière action a ouvert les réglages système.
  final bool reglagesOuverts;

  /// L'app peut afficher ET déclencher des alarmes.
  bool get complet => notifications && alarmesExactes;

  EtatPermission copyWith({bool? notifications, bool? alarmesExactes, bool? reglagesOuverts}) {
    return EtatPermission(
      notifications: notifications ?? this.notifications,
      alarmesExactes: alarmesExactes ?? this.alarmesExactes,
      reglagesOuverts: reglagesOuverts ?? this.reglagesOuverts,
    );
  }

  @override
  List<Object?> get props => [notifications, alarmesExactes, reglagesOuverts];

  @override
  String toString() =>
      'EtatPermission(notifications: $notifications, alarmesExactes: $alarmesExactes)';
}
