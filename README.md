# to_doia

A new Flutter project.

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