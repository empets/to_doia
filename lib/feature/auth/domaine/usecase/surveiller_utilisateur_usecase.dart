import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:grace_church/core/service_systeme/error/failure.dart';
import 'package:grace_church/core/service_systeme/usercase/usercase.dart';
import 'package:grace_church/feature/auth/domaine/entities/utilisateur_entite.dart';
import 'package:grace_church/feature/auth/domaine/repositorie/auth_repository.dart';
import 'package:injectable/injectable.dart';

/// Diffuse l'utilisateur connecté et ses changements en temps réel.
@lazySingleton
class SurveillerUtilisateurUseCase
    implements UseCaseStream<UtilisateurEntite?, EmptyRequest> {
  const SurveillerUtilisateurUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Stream<Either<Failure, UtilisateurEntite?>> call(EmptyRequest params) async* {
    try {
      await for (final utilisateur in _repository.utilisateurCourantStream()) {
        yield Right(utilisateur);
      }
    } catch (e) {
      yield Left(Failure('Lecture de la session impossible : $e'));
    }
  }
}
