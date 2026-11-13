import 'package:dartz/dartz.dart';
import 'package:grace_church/core/service_systeme/error/failure.dart';
import 'package:grace_church/core/service_systeme/usercase/usercase.dart';
import 'package:grace_church/feature/auth/domaine/repositorie/auth_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeconnecterUtilisateurUseCase implements UseCase<Unit, EmptyRequest> {
  const DeconnecterUtilisateurUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(EmptyRequest params) =>
      _repository.deconnecter();
}
