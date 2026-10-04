import 'package:grace_church/core/data_process/success.dart';
import 'package:grace_church/feature/home/domaine/entities/request/home_request.dart';

abstract class HomeRemoteRepository {
  // /// Crée une tâche à partir d'une commande vocale enregistrée.
  // ///
  // /// [audioPath] correspond au chemin local du fichier audio
  // /// contenant la commande vocale de l'utilisateur.
  // ///
  // /// Le repository se charge de transmettre cet audio au traitement
  // /// nécessaire afin d'en extraire les informations de la tâche
  // /// (titre, date, heure et récurrence).
  // ///
  // /// Retourne une [TaskResponse] contenant les informations extraites.
  // Future<ApiResult<TaskResponseModel>> createTaskFromVoice({
  //   required String audioPath,
  // });

  // Future<String> transcribe(String filePath);
  // Future<TaskResponseModel> extractTask(String text);

  Future<FirebaseResult<String?>> createTask(RequestCreateTask params);

  
}
