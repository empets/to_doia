# to_doia

A new Flutter project.

## 🔐 Configuration des secrets (obligatoire)

Aucune clé d'API n'est stockée dans le code source. Les valeurs sont injectées
au build via `--dart-define-from-file=env.json`.

1. Créer le fichier local à partir du modèle :
   ```bash
   cp env.example.json env.json
   ```
2. Renseigner les valeurs dans `env.json`. Ce fichier est **ignoré par Git**.
3. Lancer l'application :
   ```bash
   flutter run --dart-define-from-file=env.json
   ```
   Raccourci : `./run.sh` (vérifie `env.json` et ajoute l'option).
   Les configurations VS Code (`.vscode/launch.json`) et IntelliJ/Android
   Studio utilisent déjà ce fichier.
4. Pour un build release :
   ```bash
   flutter build apk --release --dart-define-from-file=env.json
   ```

> ⚠️ **Ne commitez jamais `env.json`** ni un keystore (`*.keystore`, `*.jks`).
>
> ⚠️ **La clé Groq historiquement présente dans le code a été exposée dans
> l'historique Git.** Elle doit être **révoquée** depuis la console Groq, même
> après sa suppression du code. Une clé publiée reste compromise.
>
> ⚠️ `--dart-define` compile la valeur dans le binaire : elle reste
> extractible. Pour la production, les appels Groq doivent passer par un
> proxy backend (Cloud Function) qui conserve la clé côté serveur.

## 🎙️ Permissions

- **Android** : `INTERNET`, `RECORD_AUDIO` et `POST_NOTIFICATIONS` sont déclarés
  dans `android/app/src/main/AndroidManifest.xml`.
- **iOS** : les descriptions d'usage du micro et de la reconnaissance vocale
  sont dans `ios/Runner/Info.plist`, et les macros `permission_handler` sont
  activées dans `ios/Podfile`.
- L'écran de permissions demande réellement les autorisations système. En cas
  de refus définitif, un bouton ouvre les réglages de l'application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


Structure complète du projet :

lib/
├── main.dart                   
├── models/
│   └── task.dart
├── screens/
│   ├── splash_screen.dart
│   ├── permissions_screen.dart
│   ├── home_screen.dart
│   ├── voice_listening_screen.dart
│   ├── transcription_screen.dart
│   ├── ai_analyzing_screen.dart
│   ├── confirmation_screen.dart
│   ├── success_screen.dart
│   ├── tasks_screen.dart
│   ├── manual_create_screen.dart
│   ├── settings_screen.dart
│   └── settings_sub_screens.dart
└── widgets/
    └── task_card.dart# to_doia

arrête le flutter pub run build_runner build et lance pkill -f build_runner; pkill dart