import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:grace_church/core/constante/global_params.dart';
import 'package:grace_church/core/service_systeme/error/failure.dart';
import 'package:grace_church/feature/setting/domaine/entities/feedback_entite.dart';
import 'package:grace_church/feature/setting/domaine/repositorie/feedback_repository.dart';
import 'package:injectable/injectable.dart';

/// Envoie les retours utilisateur dans la collection Firestore `feedbacks`.
@LazySingleton(as: FeedbackRepository)
class FeedbackRepositoryImpl implements FeedbackRepository {
  FeedbackRepositoryImpl(this._firestore);

  final FirebaseFirestore _firestore;

  static const String _collection = 'feedbacks';

  @override
  Future<Either<Failure, Unit>> envoyer(FeedbackEntite feedback) async {
    try {
      await _firestore.collection(_collection).add({
        ...feedback.toMap(),
        'appareil': await _infosAppareil(),
        'creeLe': FieldValue.serverTimestamp(),
        'statut': 'nouveau',
      });
      return const Right(unit);
    } catch (e) {
      return Left(Failure("Échec de l'envoi du retour : $e"));
    }
  }

  /// Métadonnées de diagnostic jointes automatiquement au retour.
  ///
  /// En cas d'échec de lecture de l'appareil, l'envoi continue avec les
  /// informations disponibles : un retour utilisateur ne doit pas être perdu
  /// à cause d'une simple erreur de collecte.
  Future<Map<String, String>> _infosAppareil() async {
    final infos = <String, String>{
      'versionApplication': GlobalParams.appVersion,
      'langue': Platform.localeName,
      'plateforme': Platform.operatingSystem,
    };

    try {
      final plugin = DeviceInfoPlugin();

      if (Platform.isAndroid) {
        final appareil = await plugin.androidInfo;
        infos['appareil'] = '${appareil.manufacturer} ${appareil.model}';
        infos['systeme'] = 'Android ${appareil.version.release}';
      } else if (Platform.isIOS) {
        final appareil = await plugin.iosInfo;
        infos['appareil'] = appareil.utsname.machine;
        infos['systeme'] = '${appareil.systemName} ${appareil.systemVersion}';
      } else if (Platform.isMacOS) {
        final appareil = await plugin.macOsInfo;
        infos['appareil'] = appareil.model;
        infos['systeme'] = 'macOS ${appareil.osRelease}';
      }
    } catch (_) {
      // Métadonnées facultatives : on garde les champs déjà renseignés.
    }

    return infos;
  }
}
