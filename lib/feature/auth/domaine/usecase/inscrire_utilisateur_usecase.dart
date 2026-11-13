import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:grace_church/core/service_systeme/error/failure.dart';
import 'package:grace_church/core/service_systeme/usercase/usercase.dart';
import 'package:grace_church/feature/auth/domaine/entities/utilisateur_entite.dart';
import 'package:grace_church/feature/auth/domaine/repositorie/auth_repository.dart';
import 'package:injectable/injectable.dart';

/// Paramètres de création de compte.
class InscriptionParams extends Equatable {
  const InscriptionParams({
    required this.nom,
    required this.email,
    required this.motDePasse,
  });

  final String nom;
  final String email;
  final String motDePasse;

  @override
  List<Object> get props => [nom, email, motDePasse];
}

@lazySingleton
class InscrireUtilisateurUseCase
    implements UseCase<UtilisateurEntite, InscriptionParams> {
  const InscrireUtilisateurUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, UtilisateurEntite>> call(InscriptionParams params) =>
      _repository.inscrire(
        nom: params.nom,
        email: params.email,
        motDePasse: params.motDePasse,
      );
}
