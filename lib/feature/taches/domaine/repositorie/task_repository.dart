import 'package:dartz/dartz.dart';
import 'package:grace_church/core/service_systeme/error/failure.dart';
import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';
import 'package:grace_church/feature/taches/domaine/entities/request/task_request.dart';

abstract class TaskRepository{

  // ---------------------------------------------------------------------------------------------
  // cette interface permet de recuper la liste des tache 
  // il prend en paramètre un objet RequestNotParams qui contient les parametre de la requette 
  // il retourne un objet TaskResponse qui contient la liste des taches
  // ---------------------------------------------------------------------------------------------
  Future<Either<Failure, List<TaskResponse>>> getTaskList(RequestNotParams request);

}