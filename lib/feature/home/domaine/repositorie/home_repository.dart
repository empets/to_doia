import 'package:dartz/dartz.dart';
import 'package:grace_church/core/service_systeme/error/failure.dart';
import 'package:grace_church/feature/home/domaine/entities/request/home_request.dart';
import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';

abstract class HomeRepository{
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
  Future<Either<Failure, TaskResponse>> createTaskFromVoice({
    required String audioPath,
  });

  // ---------------------------------------------------------------------------------------------
  // cette interface permet de creer une tache 
  // il prend en paramètre un objet RequestCreateTask qui contient les parametre de la requette 
  // il retourne un objet String? qui contient l'id de la tache cree
  // ---------------------------------------------------------------------------------------------
  Future<Either<Failure, String?>> createTask(RequestCreateTask request);

}