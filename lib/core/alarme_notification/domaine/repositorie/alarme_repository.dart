import 'package:dartz/dartz.dart';

import 'package:grace_church/core/service_systeme/error/failure.dart';
import 'package:grace_church/core/alarme_notification/domaine/entities/alarme_entite.dart';

/// Contrat (couche domaine) : gestion des alarmes.
///
/// Toute feature qui doit créer / modifier / supprimer une alarme passe par
/// ce contrat. L'implémentation concrète vit dans `data/repository/`
/// (adaptation de `flutter_local_notifications` + `timezone`).
abstract class AlarmeRepository {
  /// Programme (crée ou re-crée) une alarme.
  ///
  /// Si [alarme.joursDeRepetition] est vide, l'alarme sonne une seule fois à
  /// [alarme.dateHeure] ; sinon elle se répète chaque semaine aux jours actifs.
  Future<Either<Failure, Unit>> programmer(AlarmeEntite alarme);

  /// Modifie une alarme existante (annule puis re-programme avec le même id).
  Future<Either<Failure, Unit>> modifier(AlarmeEntite alarme);

  /// Supprime une alarme par son identifiant.
  Future<Either<Failure, Unit>> supprimer(int idAlarme);

  /// Déclenche immédiatement une alarme (sans attendre sa programmation).
  Future<Either<Failure, Unit>> declencher(AlarmeEntite alarme);

  /// Liste les identifiants des alarmes actuellement en attente sur l'OS.
  Future<Either<Failure, List<int>>> alarmesEnAttente();

  /// Supprime toutes les alarmes programmées par l'application.
  Future<Either<Failure, Unit>> toutSupprimer();
}
