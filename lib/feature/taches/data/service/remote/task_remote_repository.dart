import 'package:grace_church/core/data_process/success.dart';
import 'package:grace_church/feature/home/data/model/home_responses_models.dart';
import 'package:grace_church/feature/taches/domaine/entities/request/task_request.dart';

abstract class TaskRemoteRepository {
   
  /// Récupère la liste des tâches d'un utilisateur.
  ///
  /// [params] : objet [RequestNotParams] contenant l'identifiant de
  /// l'utilisateur dont on veut récupérer les tâches.
  ///
  /// Retourne un [FirebaseResult] qui encapsule :
  /// - en cas de succès : une `List<TaskResponseModel>` (vide si l'utilisateur
  ///   n'a aucune tâche) ;
  /// - en cas d'échec : l'erreur Firebase correspondante.
  Future<FirebaseResult<List<TaskResponseModel>>> getTaskList(
    RequestNotParams params,
  );
  
}
