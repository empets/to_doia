# Daily Resume — To Doia

**Date :** 2 novembre 2026  
**Projet :** `/Users/admin/Documents/to_doia`  
**Branche :** `feature/production`

## 1. Résumé de la journée

La journée a porté sur la configuration de l'environnement de développement, le
diagnostic de l'application Flutter, la correction du module d'alarmes et la
publication du projet sur GitHub.

## 2. Travaux réalisés

### Configuration et outils

- Installation de **Graphicle 0.1.11** via Homebrew.
- Indexation du projet avec Graphicle :
  - 179 fichiers analysés ;
  - 1 965 nœuds de code ;
  - 3 202 relations dans le graphe.
- Démarrage du serveur Graphicle sur `http://127.0.0.1:8854`.
- Vérification de l'accès à l'outil depuis le terminal avec `graphicle status`,
  `graphicle ask` et `graphicle sync`.

### Firebase, agents et logs

- Vérification de l'intégration Firebase existante dans l'application.
- Confirmation de l'utilisation de `firebase_core`, `firebase_auth`,
  `firebase_database`, `cloud_firestore`, `firebase_storage` et
  `firebase_messaging`.
- Analyse de la configuration MCP : la dépendance `mcp_dart` est présente, mais
  aucun serveur MCP Firebase complet n'est encore implémenté.
- Lecture des logs Android via ADB sur l'appareil `R5CY54LY2ZB`.
- Aucun crash ou message d'erreur Firebase, Firestore, Auth, Groq ou permission
  n'a été trouvé dans le buffer disponible.

### Correction Gradle / Android

Dans `android/app/build.gradle.kts` :

- déplacement de `isCoreLibraryDesugaringEnabled = true` vers `compileOptions` ;
- migration de `kotlinOptions.jvmTarget` vers la DSL `compilerOptions` ;
- configuration de la cible JVM Kotlin sur Java 17.

La première erreur Gradle est corrigée. La compilation reste dépendante d'un
JDK compatible : l'environnement local utilise actuellement Java 25.0.2,
alors que la configuration du projet cible Java 17.

### Correction du module alarmes / notifications

Fichier corrigé :

`lib/core/alarme_notification/domaine/entities/alarme_entite.dart`

Cause de l'erreur : `jsonEncode` ne permet pas les clés de map de type `int`.
La map de répétition `{1: true, 3: true}` provoquait :

```text
Converting object to an encodable object failed: _ConstMap len:1
```

Correction appliquée :

- conversion des clés de `joursDeRepetition` en chaînes dans `toJson()` ;
- reconversion des clés en entiers dans `fromJson()` ;
- prise en charge renforcée des maps décodées depuis JSON.

Vérification effectuée :

```text
flutter analyze ...
No issues found!
```

## 3. Publication Git

- Commit créé : `feat: add alarm notifications and update app configuration`.
- Le premier push a été bloqué par GitHub Push Protection à cause d'une ancienne
  clé Groq présente dans l'historique.
- L'historique Git a été nettoyé et les anciennes chaînes ressemblant à des clés
  Groq ont été remplacées par des valeurs neutres.
- `env.json` et les fichiers générés/temporaire n'ont pas été poussés.
- Push final réussi vers : `origin/feature/production`.
- Commit distant final : `5e9000a`.
- Le dépôt local est propre après publication.

## 4. État actuel

### Terminé

- Correction de la sérialisation des alarmes.
- Configuration Gradle du désucrage corrigée.
- Graphicle installé et opérationnel.
- Projet publié sur GitHub.
- Secrets retirés de l'historique publié.

### À faire

1. Installer et utiliser un JDK 17 pour valider complètement le build Android.
2. Révoquer l'ancienne clé Groq depuis la console Groq si cela n'a pas encore été
   fait.
3. Tester une alarme répétée et une alarme ponctuelle sur un appareil Android.
4. Implémenter le serveur MCP Firebase si l'agent doit lire ou modifier les
   données Firebase.
5. Ajouter Firebase Crashlytics, Analytics ou Performance Monitoring pour
   obtenir des métriques persistantes plutôt que des logs ponctuels.

## 5. Commandes utiles

```bash
cd /Users/admin/Documents/to_doia

# Vérifier le dépôt
git status
git log -1 --oneline

# Vérifier Graphicle
graphicle status
graphicle sync

# Lancer Graphicle
graphicle serve --open --port 8854

# Analyser le module alarme
flutter analyze lib/core/alarme_notification
```

> Ne jamais versionner `env.json`, les clés Firebase Admin, les clés Groq, les
> tokens ou les keystores Android.