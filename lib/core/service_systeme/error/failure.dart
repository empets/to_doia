import 'package:equatable/equatable.dart';
import 'package:to_doia/core/extention/app_extention.dart';

/// Codes stables identifiant les messages d'erreur génériques centralisés
/// dans `AppLocalizations` (voir `failure_l10n.dart`). La couche data ne
/// peut pas accéder à un `BuildContext` pour résoudre le texte localisé :
/// elle se contente de poser le code sur le [Failure], et c'est la couche
/// présentation qui appelle `Failure.localizedMessage(context)` pour
/// obtenir le texte français depuis l'ARB au moment de l'affichage.
abstract final class FailureCode {
  static const errorServeur = 'errorServeur';
  static const errorTimeOut = 'errorTimeOut';
  static const errorInternetFailed = 'errorInternetFailed';
  static const errorClientException = 'errorClientException';
  static const apiErrorUnknown = 'apiErrorUnknown';
  static const apiErrrorConnection = 'apiErrrorConnection';
}

abstract class Failure extends Equatable {
  const Failure({this.code, this.message});

  final String? message;
  final String? code;

  @override
  List<Object> get props => [code.getOrEmpty(), message.getOrEmpty()];
}

class APIErrorFailure extends Failure {
  const APIErrorFailure({String message = ''}) : super(message: message);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({String message = '', String code = ''})
      : super(message: message, code: code);
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure({String code = '', String message = ''})
      : super(message: message, code: code);
}

class InvalidFormatFailure extends Failure {
  const InvalidFormatFailure({String code = '', String message = ''})
      : super(message: message, code: code);
}

class NetworkFailure extends Failure {
  const NetworkFailure({String message = '', String code = ''})
      : super(message: message, code: code);
}

class InternalFailure extends Failure {
  const InternalFailure({String message = ''}) : super(message: message);
}

// General failures
class PlateFormFailure extends Failure {
  const PlateFormFailure({String message = ''}) : super(message: message);
}

class PlatformFailure extends Failure {
  const PlatformFailure({String message = ''}) : super(message: message);
}

class CacheFailure extends Failure {
  const CacheFailure([String message = 'Cache non disponible'])
      : super(message: message);
}

class CancelledByUser extends Failure {}

class LogoutFailure extends Failure {}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({String message = 'Session expirée'})
      : super(message: message);
}

/// Erreur d'API (4xx)
class ApiFailure extends Failure {
  const ApiFailure([String message = 'Une erreur est survenue'])
      : super(message: message);
}

/// Erreur de parsing JSON
class ParsingFailure extends Failure {
  const ParsingFailure({String message = ''}) : super(message: message);
}

/// Erreur inconnue
class UnknownFailure extends Failure {
  const UnknownFailure([String message = 'Une erreur inconnue est survenue'])
      : super(message: message);
}

/// Exception pour les erreurs réseau
class NetworkException implements Exception {
  NetworkException({this.message = 'Pas de connexion internet'});
  final String message;

  @override
  String toString() => message;
}

/// Exception pour les erreurs d'API
class ApiException implements Exception {
  ApiException({this.message = 'Une erreur est survenue'});
  final String message;

  @override
  String toString() => message;
}

/// Exception pour les erreurs de parsing
class ParsingException implements Exception {
  ParsingException({this.message = 'Erreur de traitement des données'});
  final String message;

  @override
  String toString() => message;
}

class ScanCancelledFailure extends Failure {
  const ScanCancelledFailure() : super();
}

class CaptureFailure extends Failure {
  const CaptureFailure({String message = 'Capture echouée'})
      : super(message: message);
}

class OcrFailure extends Failure {
  const OcrFailure({String message = 'OCR échouée'}) : super(message: message);
}

class InvalidScanFailure extends Failure {
  const InvalidScanFailure({String message = 'Invalide Scan '})
      : super(message: message);
}

class ExtractionFailure extends Failure {
  const ExtractionFailure({String message = 'Extraction echouée'})
      : super(message: message);
}

class CannotLaunchFailure extends Failure {
  const CannotLaunchFailure({String message = 'Échec du lancement'})
      : super(message: message);
}

class InvalidUriFailure extends Failure {
  const InvalidUriFailure({String message = "Erreur d'URI non valide"})
      : super(message: message);
}
