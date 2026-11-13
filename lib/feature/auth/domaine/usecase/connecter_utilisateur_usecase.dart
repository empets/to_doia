import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:grace_church/core/service_systeme/error/failure.dart';
import 'package:grace_church/core/service_systeme/usercase/usercase.dart';
import 'package:grace_church/feature/auth/domaine/entities/utilisateur_entite.dart';
import 'package:grace_church/feature/auth/domaine/repositorie/auth_repository.dart';
import 'package:injectable/injectable.dart';

/// Paramètres de connexion par e-mail.
class ConnexionParams extends Equatable {
  const ConnexionParams({required this.email, required this.motDePasse});

  final String email;
  final String motDePasse;

  @override
  List<Object> get props => [email, motDePasse];
}

@lazySingleton
class ConnecterUtilisateurUseCase
    implements UseCase<UtilisateurEntite, ConnexionParams> {
  const ConnecterUtilisateurUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, UtilisateurEntite>> call(ConnexionParams params) =>
      _repository.connecter(email: params.email, motDePasse: params.motDePasse);
}
