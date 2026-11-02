import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:grace_church/core/service_systeme/error/failure.dart';
import 'package:injectable/injectable.dart';

import 'package:grace_church/core/alarme_notification/domaine/entities/alarme_entite.dart';
import 'package:grace_church/core/alarme_notification/domaine/repositorie/alarme_repository.dart';

/// UseCase : crée / programme une alarme.
@lazySingleton
class ProgrammerAlarmeUseCase extends UseCaseBase<Unit, ProgrammerAlarmeParams> {
  ProgrammerAlarmeUseCase(this._repository);

  final AlarmeRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(ProgrammerAlarmeParams params) =>
      _repository.programmer(params.alarme);
}

/// Paramètres du usecase de programmation d'alarme.
class ProgrammerAlarmeParams extends Equatable {
  const ProgrammerAlarmeParams(this.alarme);

  final AlarmeEntite alarme;

  @override
  List<Object?> get props => [alarme];
}

/// Contrat de base local au module (même forme que
/// `core/service_systeme/usercase`, importé ici pour éviter une dépendance
/// croisée ; l'implémentation reste identique).
abstract class UseCaseBase<ResponseType, Params> {
  Future<Either<Failure, ResponseType>> call(Params params);
}
