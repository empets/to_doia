
/// Codes stables identifiant les messages d'erreur génériques centralisés
/// dans `AppLocalizations` (voir `failure_l10n.dart`). La couche data ne
/// peut pas accéder à un `BuildContext` pour résoudre le texte localisé :
/// elle se contente de poser le code sur le [Failure], et c'est la couche
/// présentation qui appelle `Failure.localizedMessage(context)` pour
/// obtenir le texte français depuis l'ARB au moment de l'affichage.
class Failure {
  const Failure(this.message);
  final String message;
}

class ServerException implements Exception {
  const ServerException(this.message);
  final String message;
}