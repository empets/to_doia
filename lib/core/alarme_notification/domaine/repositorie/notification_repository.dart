import 'package:dartz/dartz.dart';

import 'package:grace_church/core/service_systeme/error/failure.dart';
import 'package:grace_church/core/alarme_notification/domaine/entities/notification_programmee_entite.dart';

/// Contrat (couche domaine) : gestion des notifications locales et programmées.
abstract class NotificationRepository {
  // ─────────────────────────── Initialisation ───────────────────────────

  /// Initialise le service de notifications.
  /// À appeler une fois, au démarrage de l'application.
  Future<Either<Failure, Unit>> initialiser();

  /// Annule tout et libère les ressources du service.
  Future<Either<Failure, Unit>> arreter();

  // ───────────────────────── Notifications locales ──────────────────────

  /// Affiche immédiatement une notification locale.
  Future<Either<Failure, Unit>> afficher(NotificationProgrammeeEntite notif);

  // ──────────────────────── Notifications programmées ───────────────────

  /// Programme une notification à [notif.dateHeure].
  Future<Either<Failure, Unit>> programmer(
    NotificationProgrammeeEntite notif,
  );

  /// Annule une notification programmée par son identifiant.
  Future<Either<Failure, Unit>> annuler(int idNotification);

  /// Liste les identifiants des notifications actuellement programmées.
  Future<Either<Failure, List<int>>> programmeeEnAttente();

  /// Annule toutes les notifications programmées.
  Future<Either<Failure, Unit>> toutAnnuler();
}
