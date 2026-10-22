import 'dart:convert';
import 'dart:developer';
import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';
import 'package:http/http.dart' as http;
import 'package:grace_church/core/service_systeme/error/failure.dart';
import 'package:grace_church/feature/home/data/model/home_responses_models.dart';

import 'package:injectable/injectable.dart';

abstract class GroqRemoteDataSource {
  Future<String> transcribe(String filePath);
  Future<TaskResponseModel> extractTask(String text);
  Future<GraceResponse> chat(List<Map<String, String>> messages);
}

@LazySingleton(as: GroqRemoteDataSource)
class GroqRemoteDataSourceImpl implements GroqRemoteDataSource {
  GroqRemoteDataSourceImpl(this._client);
  final http.Client _client;

  static const _base = 'https://api.groq.com/openai/v1';
  static const _key = '';
  //String.fromEnvironment(GlobalParams.GROQ_API_KEY);
  static const _timeout = Duration(seconds: 30);

  Map<String, String> get _auth => {'Authorization': 'Bearer $_key'};

  @override
  Future<String> transcribe(String filePath) async {
    final req =
        http.MultipartRequest('POST', Uri.parse('$_base/audio/transcriptions'))
          ..headers.addAll(_auth)
          ..fields.addAll({
            'model': 'whisper-large-v3-turbo',
            'language': 'fr',
            'response_format': 'json',
          })
          ..files.add(await http.MultipartFile.fromPath('file', filePath));

    final res = await http.Response.fromStream(
      await _client.send(req).timeout(_timeout),
    );
    log('$req');
    return _decode(res)['text'] as String;
  }

  @override
  Future<TaskResponseModel> extractTask(String text) async {
    final today = DateTime.now().toIso8601String().substring(0, 10);

    final res = await _client
        .post(
          Uri.parse('$_base/chat/completions'),
          headers: {..._auth, 'Content-Type': 'application/json'},
          body: jsonEncode({
            'model': 'openai/gpt-oss-20b',
            'temperature': 0,
            'response_format': {'type': 'json_object'},
            'messages': [
              // {
              //   'role': 'system',
              //   'content':
              //       '''
              //     Tu extrais une tâche depuis un texte en français.
              //     Date du jour : $today. Résous "demain", "lundi prochain", etc. à partir de cette date.
              //     Réponds UNIQUEMENT avec ce JSON :
              //     {"title": string|null, "date": "YYYY-MM-DD"|null, "time": "HH:mm"|null, "recurring": boolean}''',
              // },
              {
                'role': 'system',
                'content':
                    '''
                Tu extrais une tâche depuis la transcription d'un message vocal en français (le vocal peut être long).
                Date du jour : $today. Heure actuelle : ${DateTime.now().hour}:${DateTime.now().minute}.
                Résous "demain", "lundi prochain", "ce soir", etc. à partir de cette date.

                Règles :
                - "title" : titre court (max 6 mots), à l'infinitif ou nominal.
                - "content" : résumé bref du vocal (1 à 2 phrases max), sans détails inutiles ni hésitations.
                - "date" : date d'exécution au format YYYY-MM-DD, sinon null.
                - "time" : heure d'exécution au format HH:mm (24h), sinon null.
                - "recurring" : true seulement si la tâche se répète ("chaque lundi", "tous les jours").
                - "status" : "en_cours" si la tâche est déjà commencée ou à faire maintenant/aujourd'hui,
                  "a_terminer" si elle est à finir ou à faire avant une échéance,
                  "annule" si le vocal indique d'annuler/abandonner la tâche,
                  "a_venir" si elle est planifiée plus tard. Par défaut : "a_venir".
                - "recordtime" : temps d'enregistrement du vocal en secondes, sinon null.

                Réponds UNIQUEMENT avec ce JSON, sans texte autour ni markdown :
                {"title": string|null, "content": string|null, "date": "YYYY-MM-DD"|null, "time": "HH:mm"|null, "recurring": boolean, "status": "en_cours"|"a_terminer"|"annule"|"a_venir", "recordtime": number|null}''',
              },
              {'role': 'user', 'content': text},
            ],
          }),
        )
        .timeout(_timeout);

    final content = _decode(res)['choices'][0]['message']['content'] as String;
    log('Groq response: ${jsonDecode(content) as Map<String, dynamic>}');
    return TaskResponseModel.fromJson(
      jsonDecode(content) as Map<String, dynamic>,
    );
  }

  // utf8.decode(bodyBytes) : res.body décode en latin1 sans charset -> accents cassés

  Map<String, dynamic> _decode(http.Response res) {
    final body = utf8.decode(res.bodyBytes);
    if (res.statusCode != 200) {
      log('Groq ${res.statusCode} : $body');
      throw ServerException('Groq ${res.statusCode} : $body');
    }
    return jsonDecode(body) as Map<String, dynamic>;
  }

  @override
  Future<GraceResponse> chat(List<Map<String, String>> messages) async {
    final res = await _client
        .post(
          Uri.parse('$_base/chat/completions'),
          headers: {..._auth, 'Content-Type': 'application/json'},
          body: jsonEncode({
            'model': 'openai/gpt-oss-20b',
            'temperature': 0.2,
            'max_tokens': 300,
            'response_format': {'type': 'json_object'},
            'messages': [
              {
                'role': 'system',
                'content': '''
                Tu es Grace, une assistante vocale de navigation dans une application Flutter.
                Tu dois répondre en français, avec 1 à 3 phrases courtes, sans markdown ni emojis.
                Tes réponses sont lues à voix haute.

                Tu peux déclencher une navigation uniquement lorsque l'utilisateur demande
                explicitement d'ouvrir ou de consulter un écran.

                Écrans disponibles :
                - home : accueil
                - tasks : liste des tâches
                - create_task : création d'une tâche
                - settings : paramètres
                - voice : assistant vocal

                Règles :
                - Si l'utilisateur demande d'ouvrir un écran, utilise l'action navigate.
                - Si l'utilisateur pose une question ou discute, utilise l'action none.
                - Ne déclenche jamais une navigation sans demande claire.
                - N'invente pas de destinations.
                - Retourne exclusivement un JSON valide avec cette structure :
                {
                  "message": "La réponse courte à lire à voix haute",
                  "action": {
                    "type": "navigate ou none",
                    "destination": "home, tasks, create_task, settings, voice ou null"
                  }
                }
                ''',
              },
              ...messages,
            ],
          }),
        )
        .timeout(_timeout);

    final data = _decode(res);
    final content = data['choices'][0]['message']['content'] as String;

    final json = jsonDecode(content) as Map<String, dynamic>;
    final actionJson = json['action'] as Map<String, dynamic>? ?? {};

    return GraceResponse(
      message: (json['message'] as String?) ?? '',
      action: GraceAction(
        type: (actionJson['type'] as String?) ?? 'none',
        destination: actionJson['destination'] as String?,
      ),
    );
  }
}


// - "recordtime"" : il correspond au temps d'enregistrement du vocal   
