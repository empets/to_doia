import 'dart:convert';

import 'package:dio/dio.dart' as di;
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import 'package:to_doia/core/service_systeme/model/api/api_result.dart';
import 'package:to_doia/feature/home/data/model/home_responses_models.dart';
import 'package:to_doia/feature/home/data/service/remote/home_remote_repository.dart';

@LazySingleton(as: HomeRemoteRepository)
class HomeRemoteRepositoryImpl implements HomeRemoteRepository {
  HomeRemoteRepositoryImpl({required this.dio});

  final di.Dio dio;
  static const _base = 'https://api.groq.com/openai/v1';
  static const _key = String.fromEnvironment(
    '',
  );
  di.Options get _opts =>
      di.Options(headers: {'Authorization': 'Bearer $_key'});

  @override
  Future<ApiResult<TaskResponseModel>> createTaskFromVoice({
    required String audioPath,
  }) {
    // TODO: implement createTaskFromVoice
    throw UnimplementedError();
  }

  /// Vocal -> texte
  Future<String> transcribe(String filePath) async {
    final form = di.FormData.fromMap({
      'file': await di.MultipartFile.fromFile(filePath, filename: 'vocal.m4a'),
      'model': 'whisper-large-v3-turbo',
      'language': 'fr',
      'response_format': 'json',
    });
    final res = await dio.post(
      '$_base/audio/transcriptions',
      data: form,
      options: _opts,
    );
    return res.data['text'] as String;
  }

  /// Texte -> TaskResponseModel
  Future<TaskResponseModel> extractTask(String text) async {
    final now = DateTime.now();
    final today = now.toIso8601String().substring(0, 10);

    final res = await dio.post(
      '$_base/chat/completions',
      options: _opts,
      data: {
        'model': 'llama-3.3-70b-versatile',
        'temperature': 0,
        'response_format': {'type': 'json_object'},
        'messages': [
          {
            'role': 'system',
            'content':
                '''
Tu extrais une tâche depuis un texte en français.
Date du jour : $today. Résous "demain", "lundi prochain", etc. à partir de cette date.
Réponds UNIQUEMENT avec ce JSON :
{"title": string|null, "date": "YYYY-MM-DD"|null, "time": "HH:mm"|null, "recurring": boolean}
''',
          },
          {'role': 'user', 'content': text},
        ],
      },
    );

    final content = res.data['choices'][0]['message']['content'] as String;
    return TaskResponseModel.fromJson(
      jsonDecode(content) as Map<String, dynamic>,
    );
  }

  final _rec = AudioRecorder();

  Future<bool> start() async {
    if (!await _rec.hasPermission()) return false;
    final dir = await getTemporaryDirectory();
    await _rec.start(
      const RecordConfig(encoder: AudioEncoder.aacLc),
      path: '${dir.path}/vocal.m4a',
    );
    return true;
  }

  Future<String?> stop() => _rec.stop();
}
