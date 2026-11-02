import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:grace_church/core/service_systeme/error/failure.dart';
import 'package:grace_church/core/alarme_notification/domaine/entities/alarme_entite.dart';
import 'package:grace_church/core/alarme_notification/domaine/repositorie/alarme_repository.dart';
import 'package:grace_church/core/alarme_notification/data/service/local/alarme_persistance_service.dart';
import 'package:grace_church/core/alarme_notification/data/service/notification_local_service.dart';

/// Implémentation du contrat [AlarmeRepository].
///
/// Chaque alarme programmée est aussi **persistée localement**
/// ([AlarmePersistanceService]) afin de survivre au redémarrage du téléphone
/// (les alarmes ponctuelles Android sont effacées par l'OS au reboot).
@LazySingleton(as: AlarmeRepository)
class AlarmeRepositoryImpl implements AlarmeRepository {
  AlarmeRepositoryImpl(this._service, this._persistance);

  final NotificationLocalService _service;
  final AlarmePersistanceService _persistance;

  @override
  Future<Either<Failure, Unit>> programmer(AlarmeEntite alarme) async {
    try {
      if (alarme.joursDeRepetition.values.any((actif) => actif)) {
        await _service.programmerRepetee(
          alarme.id,
          alarme.titre,
          alarme.corps,
          alarme.dateHeure,
          alarme.joursDeRepetition,
          canal: alarme.channelId,
          payload: alarme.payload,
        );
      } else {
        await _service.programmer(
          alarme.id,
          alarme.titre,
          alarme.corps,
          alarme.dateHeure,
          canal: alarme.channelId,
          payload: alarme.payload,
        );
      }
      // Persistance pour re-programmation après reboot / redémarrage du process.
      await _persistance.sauvegarder(alarme);
      return right(unit);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> modifier(AlarmeEntite alarme) async {
    try {
      // 1. Annulation des occurrences existantes (id de base et dérivés).
      await _supprimerGroupe(alarme.id);
      return programmer(alarme);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> supprimer(int idAlarme) async {
    try {
      await _supprimerGroupe(idAlarme);
      await _persistance.supprimer(idAlarme);
      return right(unit);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> declencher(AlarmeEntite alarme) async {
    try {
      await _service.declencher(
        alarme.id,
        alarme.titre,
        alarme.corps,
        payload: alarme.payload,
      );
      return right(unit);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<int>>> alarmesEnAttente() async {
    try {
      final enAttente = await _service.enAttente();
      // Chaque alarme répétée crée id*10+jour ; on mémorise l'id de base dans
      // le payload. On expose uniquement les ids de base distincts.
      final ids = <int>{};
      for (final n in enAttente) {
        if (n.payload != null && (n.payload?.contains('alarmeBase=') ?? false)) {
          final base = n.payload!.split('&').firstWhere(
                (p) => p.startsWith('alarmeBase='),
              );
          ids.add(int.tryParse(base.split('=').last) ?? n.id);
        } else {
          ids.add(n.id);
        }
      }
      return right(ids.toList());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> toutSupprimer() async {
    try {
      await _service.toutAnnuler();
      await _persistance.toutSupprimer();
      return right(unit);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<void> _supprimerGroupe(int idAlarme) async {
    for (var jour = 1; jour <= 7; jour++) {
      try {
        await _service.annuler(idAlarme * 10 + jour);
      } catch (_) {
        // Occurrence inexistante : rien à faire.
      }
    }
    await _service.annuler(idAlarme);
  }
}
