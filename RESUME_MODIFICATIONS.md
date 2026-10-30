# Résumé des modifications

**Nom du fichier :** `RESUME_MODIFICATIONS.md`

**Date :** 30 octobre 2026

**Objectif :** sécuriser les clés d'API, permettre le lancement de l'application
sans friction, et brancher réellement les permissions micro/notifications.

---

## 1. Fichier récapitulatif

| Fichier | Type | Rôle |
|---|---|---|
| `RESUME_MODIFICATIONS.md` | Nouveau | Ce résumé |
| `.gitignore` | Modifié | Ignore `env.json`, `*.keystore`, `*.jks` |
| `env.example.json` | Nouveau | Modèle de configuration sans valeurs |
| `env.json` | Retiré de Git | Configuration locale réelle, désormais non versionnée |
| `lib/core/constante/global_params.dart` | Modifié | Toutes les clés via `String.fromEnvironment` |
| `lib/main.dart` | Modifié | Validation de la configuration Firebase au démarrage |
| `lib/feature/home/data/service/remote/groq_remote_data_soucre.dart` | Modifié | Clé Groq lue depuis l'environnement, plus de clé en dur |
| `lib/core/persmission/permission_screen.dart` | Modifié | Demandes réelles des permissions micro/notifications |
| `android/app/src/main/AndroidManifest.xml` | Modifié | Ajout `INTERNET` et `POST_NOTIFICATIONS`, label corrigé |
| `ios/Runner/Info.plist` | Modifié | Descriptions d'usage micro et reconnaissance vocale |
| `ios/Podfile` | Modifié | Macros `permission_handler` pour iOS |
| `.vscode/launch.json` | Nouveau | Lancement VS Code avec `env.json` |
| `.idea/runConfigurations/main_dart.xml` | Modifié | Lancement IntelliJ/Android Studio avec `env.json` |
| `run.sh` | Nouveau | Script de lancement avec vérification de `env.json` |
| `README.md` | Modifié | Documentation secrets, lancement et permissions |

---

## 2. Sécurité des clés API

### `env.json`
- Retiré du suivi Git avec `git rm --cached env.json`.
- Toujours présent localement pour le développement.
- Désormais ignoré par Git via `.gitignore`.

### `env.example.json`
Modèle versionné, sans aucune valeur :

```json
{
  "FIREBASE_API_KEY": "",
  "FIREBASE_APP_ID": "",
  "FIREBASE_MESSAGING_SENDER_ID": "",
  "FIREBASE_PROJECT_ID": "",
  "FIREBASE_STORAGE_BUCKET": "",
  "SUPABASE_URL": "",
  "SUPABASE_ANON_KEY": "",
  "GROQ_API_KEY": ""
}
```

### `lib/core/constante/global_params.dart`
- Suppression de toutes les clés Firebase et Supabase écrites en dur.
- Remplacement par `String.fromEnvironment(...)`.
- Ajout de `groqApiKey`.
- Ajout de `validateFirebaseConfiguration()` avec message d'erreur explicite.
- Commentaires de sécurité détaillés (rotation de la clé, limite de
  `--dart-define`, proxy backend recommandé).

### `lib/main.dart`
- Appel de `GlobalParams.validateFirebaseConfiguration()` avant
  `Firebase.initializeApp`.
- Commentaire rappelant que les clés viennent de `env.json`.

### `lib/feature/home/data/service/remote/groq_remote_data_soucre.dart`
- Suppression de la clé Groq codée en dur.
- Utilisation de `GlobalParams.groqApiKey`.
- `ServerException` explicite si la clé est absente.
- Commentaires sur la révocation obligatoire et le proxy backend.

---

## 3. Lancement de l'application

### `run.sh`
Script exécutable qui :
1. vérifie la présence de `env.json` ;
2. crée `env.json` depuis `env.example.json` s'il manque ;
3. lance `flutter run --dart-define-from-file=env.json`.

Usage :

```bash
./run.sh
./run.sh -d emulator-5554
```

### `.vscode/launch.json`
Configuration « To Doia (env.json) » avec l'argument
`--dart-define-from-file=env.json`.

### `.idea/runConfigurations/main_dart.xml`
Ajout de l'option `--dart-define-from-file=env.json` à la configuration
existante, pour IntelliJ/Android Studio.

### `README.md`
Ajout des sections :
- « 🔐 Configuration des secrets (obligatoire) » ;
- « 🎙️ Permissions » ;
- commandes de lancement et de build release.

---

## 4. Permissions

### `lib/core/persmission/permission_screen.dart`
- Remplacement de l'ancien bouton décoratif par de vraies demandes système.
- Micro : `Permission.microphone.request()`.
- Notifications : `Permission.notification.request()`.
- Gestion des cas : accordée, refusée, refusée définitivement.
- Dialog propose d'ouvrir les réglages via `openAppSettings()`.
- Indicateur de chargement pendant la demande.
- L'utilisateur peut continuer sans autoriser.

### `android/app/src/main/AndroidManifest.xml`
Ajout de :

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.RECORD_AUDIO"/>
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
```

Le label de l'application passe de `to doia` à `To Doia`.

> `INTERNET` était uniquement dans les manifests `debug` et `profile` :
> les builds release n'avaient pas accès au réseau.

### `ios/Runner/Info.plist`
Ajout de :

- `NSMicrophoneUsageDescription`
- `NSSpeechRecognitionUsageDescription`

Sans ces clés, iOS peut faire planter l'application au premier accès micro et
refuser la publication App Store.

### `ios/Podfile`
Ajout des macros `permission_handler` :

```ruby
PERMISSION_MICROPHONE=1
PERMISSION_NOTIFICATIONS=1
```

Sans elles, les demandes de permission iOS renvoient toujours « refusé ».

---

## 5. Vérifications effectuées

- `flutter analyze --no-pub` : aucune erreur dans les fichiers modifiés.
- Les 2 erreurs restantes concernent uniquement `test/widget_test.dart`
  (test template obsolète, déjà cassé avant ces modifications).
- `git check-ignore env.json` confirme que le fichier est bien ignoré.

> Le build APK de validation a été interrompu et n'a pas été mené jusqu'au bout.

---

## 6. Actions manuelles restantes

1. **Révoquer l'ancienne clé Groq** depuis la console Groq : elle reste
   compromise même après suppression du code, car elle est dans l'historique
   Git.
2. Générer une nouvelle clé et la placer dans `env.json` :
   ```json
   "GROQ_API_KEY": "REDACTED_GROQ_KEY"
   ```
3. Lancer :
   ```bash
   ./run.sh
   ```
4. Sur iOS, exécuter un `pod install` (généralement automatique via Flutter)
   après modification du `Podfile`.
5. Commiter la suppression de `env.json` et les autres fichiers modifiés.

> ⚠️ Ne jamais commiter `env.json`. Pour la production, déplacer les appels
> Groq vers un proxy backend afin que la clé ne soit plus présente dans le
> binaire de l'application.
