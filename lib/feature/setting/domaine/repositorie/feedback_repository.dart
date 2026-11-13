import 'package:dartz/dartz.dart';
import 'package:grace_church/core/service_systeme/error/failure.dart';
import 'package:grace_church/feature/setting/domaine/entities/feedback_entite.dart';

abstract class FeedbackRepository {
  /// Cette interface permet d'envoyer un retour utilisateur vers Firebase.
  /// Elle prend en paramètre un objet [FeedbackEntite] contenant le message,
  /// le type de retour et l'e-mail facultatif.
  /// Elle retourne [Unit] en cas de succès, ou un [Failure] si l'envoi échoue.
  Future<Either<Failure, Unit>> envoyer(FeedbackEntite feedback);
}
