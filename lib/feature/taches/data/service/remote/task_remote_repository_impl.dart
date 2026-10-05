import 'package:firebase_database/firebase_database.dart' as databaseReference;
import 'package:grace_church/feature/home/data/model/home_responses_models.dart';
import 'package:grace_church/feature/taches/data/service/remote/task_remote_repository.dart';
import 'package:grace_church/feature/taches/domaine/entities/request/task_request.dart';
import 'package:injectable/injectable.dart';
import 'package:grace_church/core/data_process/success.dart';


@LazySingleton(as: TaskRemoteRepository)
class TaskRemoteRepositoryImpl implements TaskRemoteRepository {
  TaskRemoteRepositoryImpl({required this.db});

  final databaseReference.DatabaseReference db;

  @override
  Future<FirebaseResult<List<TaskResponseModel>>> getTaskList(
    RequestNotParams params,
  ) async {
    try {
      switch (params) {
        case RequestNotParams(id: final id) when id.isNotEmpty:
          final snapshot = await db
              .child('task')
              .orderByChild('userId')
              .equalTo(params.id)
              .get();
          if (snapshot.exists) {
            final data = snapshot.value as Map<dynamic, dynamic>;

            final notifications = data.values.map((e) {
              final notificationItem = Map<String, dynamic>.from(e);

              return TaskResponseModel.fromJson(notificationItem);
            }).toList();

            return FirebaseSuccess(
              notifications
                  .map((e) => TaskResponseModel.fromJson(e.toJson()))
                  .toList(),
            );
          }
          return FirebaseError("Aucune cellule trouvée");

        default:
          final snapshot = await db.child('task').get();
          if (snapshot.exists) {
            final data = snapshot.value as Map<dynamic, dynamic>;

            final notifications = data.values.map((e) {
              final notificationItem = Map<String, dynamic>.from(e);
              return TaskResponseModel.fromJson(notificationItem);
            }).toList();
            return FirebaseSuccess(
              notifications
                  .map((e) => TaskResponseModel.fromJson(e.toJson()))
                  .toList(),
            );
          }
          return FirebaseError("Aucune notification trouvée");
      }
    } catch (e) {
      return FirebaseError(e.toString());
    }
  }
}
