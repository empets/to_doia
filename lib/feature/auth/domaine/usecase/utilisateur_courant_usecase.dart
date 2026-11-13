import 'package:dartz/dartz.dart';
import 'package:grace_church/core/service_systeme/error/failure.dart';
import 'package:grace_church/core/service_systeme/usercase/usercase.dart';
import 'package:grace_church/feature/auth/domaine/entities/utilisateur_entite.dart';
import 'package:grace_church/feature/auth/domaine/repositorie/auth_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UtilisateurCourantUseCase
    implements UseCase<UtilisateurEntite?, EmptyRequest> {
  const UtilisateurCourantUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, UtilisateurEntite?>> call(EmptyRequest params) =>
      _repository.utilisateurCourant();
}
