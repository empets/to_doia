import 'package:dartz/dartz.dart';
import 'package:grace_church/core/service_systeme/error/failure.dart';
import 'package:grace_church/core/service_systeme/usercase/usercase.dart';
import 'package:grace_church/feature/setting/domaine/entities/feedback_entite.dart';
import 'package:grace_church/feature/setting/domaine/repositorie/feedback_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class EnvoyerFeedbackUseCase implements UseCase<Unit, FeedbackEntite> {
  const EnvoyerFeedbackUseCase(this._repository);

  final FeedbackRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(FeedbackEntite feedback) =>
      _repository.envoyer(feedback);
}
