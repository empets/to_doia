import 'package:to_doia/core/service_systeme/model/api/api_result.dart';
import 'package:to_doia/feature/home/data/home_responses_models.dart';

abstract class HomeRemoteRepository {
  /// Crée une tâche à partir d'une commande vocale enregistrée.
  ///
  /// [audioPath] correspond au chemin local du fichier audio
  /// contenant la commande vocale de l'utilisateur.
  ///
  /// Le repository se charge de transmettre cet audio au traitement
  /// nécessaire afin d'en extraire les informations de la tâche
  /// (titre, date, heure et récurrence).
  ///
  /// Retourne une [TaskResponse] contenant les informations extraites.
  Future<ApiResult<TaskResponseModel>> createTaskFromVoice({
    required String audioPath,
  });
}