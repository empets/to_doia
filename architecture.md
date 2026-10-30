# Architecture du projet — to_doia

Application **Flutter** (to-do list avec assistant IA « Shara », création de tâches
vocale via transcription + analyse Groq), structurée en **Clean Architecture modulaire**.

---

## 🌳 Arbre du projet

```
to_doia/
│
├── android/                     # Plateforme Android (Gradle, manifeste, permissions : RECORD_AUDIO, INTERNET, POST_NOTIFICATIONS)
├── ios/                         # Plateforme iOS (projet Xcode Runner, icônes, tests RunnerTests)
├── linux/                       # Plateforme Linux (généré par Flutter)
├── macos/                       # Plateforme macOS (généré par Flutter)
├── build/                       # Fichiers générés par le build — NE JAMAIS MODIFIER
├── s/                           # (vide / brouillon)
│
├── pubspec.yaml                 # Dépendances Dart
├── env.example.json             # Modèle des clés d'API
├── env.json                     # Clés réelles injectées au build (ignoré par Git)
├── run.sh                       # Lance l'app avec --dart-define-from-file=env.json
├── architecture.md              # Ce fichier
│
├── test/                        # Tests Flutter
│   └── widget_test.dart
│
└── lib/                         # ★ TOUT LE CODE DE L'APPLICATION ★
    │
    ├── main.dart                # Point d'entrée de l'app
    │
    ├── core/                    # ★ COUCHE PARTAGÉE (utilisée par toutes les features) ★
    │   │
    │   ├── alert/               # Alertes / notifications
    │   │   └── app_alerte.dart
    │   │
    │   ├── confirmation/        # Écrans / dialogs de confirmation
    │   │   └── confimation_screen.dart
    │   │
    │   ├── constante/           # Constantes globales
    │   │   ├── constantes.dart
    │   │   └── global_params.dart
    │   │
    │   ├── custome_widget/      # Widgets réutilisables (UI custom)
    │   │   ├── button.dart          # Boutons
    │   │   ├── custome_text.dart    # Textes stylés
    │   │   ├── dater.dart           # Sélecteur de date
    │   │   ├── form_filed.dart      # Champs de formulaire
    │   │   └── navigate.dart        # Navigation
    │   │
    │   ├── data_process/        # Traitement des résultats de requêtes
    │   │   ├── failure.dart         # Représentation des échecs
    │   │   ├── success.dart         # Représentation des succès
    │   │   └── request/             # Modèle de requête (@freezed, généré)
    │   │
    │   ├── extention/           # Extensions Dart utilitaires
    │   │   └── app_extention.dart
    │   │
    │   ├── ia_analyse/          # Analyse par IA (Groq)
    │   │   └── ai_analyzing_screen.dart
    │   │
    │   ├── injetction/          # Injection de dépendances (get_it / injectable)
    │   │   ├── injection_container.dart
    │   │   ├── injection_container.config.dart   # Généré
    │   │   └── init_voice_task.dart              # Init des tâches vocales
    │   │
    │   ├── models/              # Modèles métier partagés
    │   │   └── task.dart            # Modèle Tâche
    │   │
    │   ├── observer/            # Observateurs (routes, blocs)
    │   │
    │   ├── persmission/         # Gestion des permissions système
    │   │   └── permission_screen.dart
    │   │
    │   ├── service_systeme/     # Infrastructure système
    │   │   ├── error/               # exception.dart, failure.dart, failure_l10n.dart
    │   │   ├── model/
    │   │   │   ├── api/             # api_error, api_result, api_state (états d'API @freezed)
    │   │   │   ├── formz_model/     # Validation de formulaires (email, password, text, contact)
    │   │   │   └── request.dart     # Modèle de requête partagé
    │   │   └── usercase/            # Contrat de base des cas d'usage
    │   │
    │   ├── succes_screen/       # Écran de succès après une opération
    │   │
    │   ├── transcription/       # Voix → texte
    │   │   └── transcription_screen.dart
    │   │
    │   └── voice/               # Écoute vocale (speech_to_text)
    │       └── voice_listening.dart
    │
    ├── feature/                 # ★ FONCTIONNALITÉS (Clean Architecture : data / domaine / presentation) ★
    │   │
    │   ├── home/                # ── Écran d'accueil : liste, stats, création de tâche ──
    │   │   ├── overview.dart
    │   │   │
    │   │   ├── data/            # Couche de données (implémentation)
    │   │   │   ├── model/           # home_responses_models (serialisation, généré)
    │   │   │   ├── repository/      # home_repository_impl, voice_task_repository_impl
    │   │   │   └── service/
    │   │   │       ├── local/       # Source de données locale (sqflite)
    │   │   │       └── remote/      # groq_remote_data_soucre (IA Groq), home_remote_repository
    │   │   │
    │   │   ├── domaine/         # Couche métier (indépendante)
    │   │   │   ├── entities/
    │   │   │   │   ├── request/     # home_request (vers API)
    │   │   │   │   └── response/    # home_responses (depuis API)
    │   │   │   ├── repositorie/     # Contrats : home_repository, voic_task_repository
    │   │   │   └── usecase/         # create_task_usecase, create_task_from_voice,
    │   │   │                        # update_task_from_usercase, shara_navigation_usecase
    │   │   │
    │   │   └── presentation/    # Couche UI
    │   │       ├── bloc/
    │   │       │   ├── create_task.dart/     # create_or_update_task_bloc + event/ + state/
    │   │       │   ├── voice_task.dart       # BLoC de la tâche vocale
    │   │       │   └── shara/                # shara_navigate_bloc (navigation IA) + PROMPTS.md
    │   │       ├── page/
    │   │       │   └── home_screen.dart      # Écran principal
    │   │       └── widget/                    # statcard, chart_whithe_grace,
    │   │                                      # empty_state, task_preview_title
    │   │
    │   ├── taches/              # ── Gestion des tâches : liste, détail, création manuelle ──
    │   │   │
    │   │   ├── data/
    │   │   │   ├── repository/      # home_repository_impl
    │   │   │   └── service/
    │   │   │       ├── local/       # Base locale (sqflite)
    │   │   │       └── remote/      # task_remote_repository (+ impl)
    │   │   │
    │   │   ├── domaine/
    │   │   │   ├── entities/
    │   │   │   │   ├── request/     # task_request
    │   │   │   │   └── response/    # home_responses
    │   │   │   ├── repositorie/     # Contrat : task_repository
    │   │   │   └── usecase/         # get_task_list_usecase, create_task_from_voice
    │   │   │
    │   │   └── presentation/
    │   │       ├── bloc/
    │   │       │   └── get_task/    # get_list_bloc + event/
    │   │       └── pages/            # tasks_screen, manual_create_screen,
    │   │                             # task_card, widget/empty_data
    │   │
    │   ├── assistant/           # ── Assistant IA « Shara » ──
    │   │   ├── shara_ai.dart              # Écran de l'assistant
    │   │   ├── shara_loading_button.dart  # Bouton de chargement IA
    │   │   └── app_bar_ia.dart            # Barre d'app IA
    │   │
    │   ├── onboarding/          # ── Démarrage ──
    │   │   └── splash_screen.dart         # Écran de lancement
    │   │
    │   └── setting/             # ── Paramètres ──
    │       ├── setting_screen.dart
    │       └── sub_setting_screen.dart
    │
    └── gen/                     # Code généré automatiquement — ne pas modifier
```

> Les fichiers `*.freezed.dart`, `*.g.dart` et `injection_container.config.dart`
> sont **générés** par build_runner (`dart run build_runner build`). Ne pas les éditer.
> Certains fichiers `s`, `e`, `ss.dart` semblent être des brouillons temporaires.

---

## 🔁 Flux d'une fonctionnalité (Clean Architecture)

```
UI (presentation/page + widget)
   ↓ événement
BLoC (presentation/bloc)          ← état de l'écran
   ↓ appelle
UseCase (domaine/usecase)         ← logique métier
   ↓ dépend du contrat
Repository (domaine/repositorie)  ← interface
   ↑ implémentée par
RepositoryImpl (data/repository)  ← implémentation
   ↓ utilise
Service local (sqflite) ou remote (API / Groq IA)
```

- **presentation** ne connaît que le domaine (les usecases).
- **data** implémente les contrats du domaine.
- Les dépendances sont assemblées par **`lib/core/injetction/injection_container.dart`**.
- Les clés d'API (Groq) viennent de **`env.json`** injecté au build via `--dart-define-from-file`.
