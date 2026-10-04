import 'dart:developer';

import 'package:firebase_database/firebase_database.dart' as databaseReference;
import 'package:injectable/injectable.dart';
import 'package:grace_church/core/data_process/success.dart';

import 'package:grace_church/core/service_systeme/model/request.dart';
import 'package:grace_church/feature/home/data/service/remote/home_remote_repository.dart';
import 'package:grace_church/feature/home/domaine/entities/request/home_request.dart';

@LazySingleton(as: HomeRemoteRepository)
class HomeRemoteRepositoryImpl implements HomeRemoteRepository {
  HomeRemoteRepositoryImpl({ required this.db});

  final databaseReference.DatabaseReference db;
//   static const _base = 'https://api.groq.com/openai/v1';
//   static const _key = String.fromEnvironment('');
//   di.Options get _opts =>
//       di.Options(headers: {'Authorization': 'Bearer $_key'});

//   @override
//   Future<ApiResult<TaskResponseModel>> createTaskFromVoice({
//     required String audioPath,
//   }) {
//     // TODO: implement createTaskFromVoice
//     throw UnimplementedError();
//   }

//   /// Vocal -> texte
//   Future<String> transcribe(String filePath) async {
//     final form = di.FormData.fromMap({
//       'file': await di.MultipartFile.fromFile(filePath, filename: 'vocal.m4a'),
//       'model': 'whisper-large-v3-turbo',
//       'language': 'fr',
//       'response_format': 'json',
//     });
//     final res = await dio.post(
//       '$_base/audio/transcriptions',
//       data: form,
//       options: _opts,
//     );
//     return res.data['text'] as String;
//   }

//   /// Texte -> TaskResponseModel
//   Future<TaskResponseModel> extractTask(String text) async {
//     final now = DateTime.now();
//     final today = now.toIso8601String().substring(0, 10);

//     final res = await dio.post(
//       '$_base/chat/completions',
//       options: _opts,
//       data: {
//         'model': 'llama-3.3-70b-versatile',
//         'temperature': 0,
//         'response_format': {'type': 'json_object'},
//         'messages': [
//           {
//             'role': 'system',
//             'content':
//                 '''
// Tu extrais une tâche depuis un texte en français.
// Date du jour : $today. Résous "demain", "lundi prochain", etc. à partir de cette date.
// Réponds UNIQUEMENT avec ce JSON :
// {"title": string|null, "date": "YYYY-MM-DD"|null, "time": "HH:mm"|null, "recurring": boolean}
// ''',
//           },
//           {'role': 'user', 'content': text},
//         ],
//       },
//     );

//     final content = res.data['choices'][0]['message']['content'] as String;
//     return TaskResponseModel.fromJson(
//       jsonDecode(content) as Map<String, dynamic>,
//     );
//   }

//   final _rec = AudioRecorder();

//   Future<bool> start() async {
//     if (!await _rec.hasPermission()) return false;
//     final dir = await getTemporaryDirectory();
//     await _rec.start(
//       const RecordConfig(encoder: AudioEncoder.aacLc),
//       path: '${dir.path}/vocal.m4a',
//     );
//     return true;
//   }

//   Future<String?> stop() => _rec.stop();

  @override
  Future<FirebaseResult<String?>> createTask(RequestCreateTask params) async {
    log("Début createTask ----------->>");
    try {
      // ici on verifie si le nom ou l'email existe deja
      final idExist = await db
          .child('task')
          .orderByChild('id')
          .equalTo(params.id)
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
}
