import 'dart:developer';

import 'package:firebase_database/firebase_database.dart' as databaseReference;
import 'package:injectable/injectable.dart';
import 'package:grace_church/core/data_process/success.dart';

import 'package:grace_church/core/service_systeme/model/request.dart';
import 'package:grace_church/feature/home/data/service/remote/home_remote_repository.dart';
import 'package:grace_church/feature/home/domaine/entities/request/home_request.dart';

@LazySingleton(as: HomeRemoteRepository)
class HomeRemoteRepositoryImpl implements HomeRemoteRepository {
  HomeRemoteRepositoryImpl({required this.db});

  final databaseReference.DatabaseReference db;

  @override
  Future<FirebaseResult<String?>> createTask(RequestCreateTask params) async {
    log("Début createTask ----------->>");
    try {
      // ici on verifie si le nom ou l'email existe deja
      final idExist = await db
          .child('task')
          .orderByChild('taskId')
          .equalTo(params.userId)
          .get();

      if (idExist.exists) {
        log("L'id existe déjà");
        return FirebaseError("L'id existe déjà");
      } else {
        // 1) Construire l'objet Request
        final request = Request<RequestCreateTask>(
          data: params.toJson(),
          user: "",
          serviceLibelle: 'serviceLibelle',
        );
        // 2) Créer une nouvelle entré ou table
        final ref = db.child('task').push();
        log("Ref ---------------->>: ${ref.key}");
        // 3) Sauvegarder dans Firebase (en convertissant en Map)
        await ref.set(request.data);

        // 4) Mettre à jour la clé
        await updateProfileKey(
          RequestTaskUpdateKey(taskId: ref.key.toString()),
        );

        // 4) Retourner le key généré
        return FirebaseSuccess(ref.key);
      }
    } catch (e) {
      return FirebaseError(e.toString());
    }
  }

  Future<FirebaseResult<String?>> updateProfileKey(
    RequestTaskUpdateKey params,
  ) async {
    try {
      final Map<String, dynamic> updates = {
        ...params.toJson(), // nouveaux champs simples
      };
      // 2) Créer une nouvelle entrée
      await db.child('task/${params.taskId}').update(updates);

      // 4) Retourner le key généré
      return FirebaseSuccess(params.taskId);
    } catch (e) {
      return FirebaseError(e.toString());
    }
  }

  @override
  Future<FirebaseResult<String?>> updateTask(RequestCreateTask params) async {
    try {
      final userIdExist = await db
          .child('task')
          .orderByChild('taskId')
          .equalTo(params.taskId)
          .get();

      if (userIdExist.exists) {
        final Map<String, dynamic> updates = {
          ...params.toJson(),
          'updateAt': DateTime.now().toIso8601String(),
        };
        // 2) Créer une nouvelle entrée
        await db.child('task/${params.taskId}').update(updates);

        // 4) Retourner le key généré
        return FirebaseSuccess(params.taskId);
      }
      return FirebaseError("impossible d'effectuer cette action");
    } catch (e) {
      return FirebaseError(e.toString());
    }
  }
}
