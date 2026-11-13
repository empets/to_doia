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
├── graphify-out/                # Graphe de l'architecture (généré)
│   └── graph.json
├── s/                           # (vide / brouillon)
│
├── test/                        # Tests Flutter unitaires et widgets
│   └── widget_test.dart
├── integration_test/            # Tests d'intégration
├── env.example.json             # Modèle des clés d'API
├── env.json                     # Clés réelles injectées au build (ignoré par Git)
├── run.sh                       # Lance l'app avec --dart-define-from-file=env.json
├── architecture/ARCHITECTURE.md # Ce fichier
│
└── lib/                         # ★ TOUT LE CODE DE L'APPLICATION ★
    │
    ├── main.dart                # Point d'entrée de l'app
    │
    ├── core/                    # ★ COUCHE PARTAGÉE (utilisée par toutes les features) ★
    │   │
    │   ├── alert/               # Alertes / notifications (snackbars UI)
    │   │   └── app_alerte.dart
    │   │
    │   ├── alarme_notification/ # ★ MODULE CENTRALISÉ — Alarmes & Notifications ★
    │   │   │                     # Réutilisable par toutes les features,
    │   │   │                     # indépendant du métier. Compatible Android
    │   │   │                     # et iOS (flutter_local_notifications,
    │   │   │                     # timezone, permission_handler).
    │   │   │
    │   │   ├── domaine/         # Couche métier (pure, sans Flutter)
    │   │   │   ├── entities/        # alarme_entite (AlarmeEntite, AppCanauxAlarme),
    │   │   │   │                    # notification_programmee_entite
    │   │   │   │                    # (NotificationProgrammeeEntite, AppCanauxNotification)
    │   │   │   ├── repositorie/     # Contrats : alarme_repository (créer, programmer,
    │   │   │   │                    # déclencher, modifier, supprimer), notification_repository
    │   │   │   │                    # (locale, programmée, cycle de vie), permission_notification_repository
    │   │   │   │                    # (vérifier / demander les autorisations, EtatPermission)
    │   │   │   └── usecase/         # programmer_alarme_usecase (ProgrammerAlarmeUseCase),
    │   │   │                        # gerer_notifications_usecase (GererNotificationsUseCase :
    │   │   │                        # afficher / programmer / annuler / init / stop),
    │   │   │                        # gerer_permission_notification_usecase
    │   │   │
    │   │   ├── data/            # Couche d'implémentation technique
    │   │   │   ├── repository/      # alarme_repository_impl, notification_repository_impl,
    │   │   │   │                    # permission_notification_repository_impl
    │   │   │   └── service/         # local/notification_local_service (adaptateur
    │   │   │                        # flutter_local_notifications + timezone)
    │   │   │
    │   │   └── service/         # Cycles de vie & actions
    │   │       └── alarme_notification_service.dart
    │   │                        # AlarmeNotificationService : initialisation au
    │   │                        # démarrage de l'app, arrêt / nettoyage, et routage
    │   │                        # des interactions utilisateur avec une
    │   │                        # notification (clic → payload → navigation)
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

---

## 🔔 Module centralisé Alarmes & Notifications (`lib/core/alarme_notification/`)

Infrastructure **réutilisable et indépendante du métier**, exposée à toutes les
features via l'injection de dépendances (get_it / injectable). La logique des
alarmes et notifications **ne doit jamais être codée en doublon** dans les
features : celles-ci consomment uniquement les **usecases** (ou les contrats de
repository si besoin fin).

### Rôle de chaque sous-dossier

| Sous-dossier | Responsabilité |
|---|---|
| `domaine/entities/` | Entités pures : `AlarmeEntite` (répétition hebdomadaire, canaux, payload), `NotificationProgrammeeEntite`. Aucune dépendance technique. |
| `domaine/repositorie/` | Contrats : `AlarmeRepository` (créer / programmer / déclencher / modifier / supprimer / lister), `NotificationRepository` (locale, programmée, annulation, cycle de vie), `PermissionNotificationRepository` (vérifier / demander / réglages, `EtatPermission`). |
| `domaine/usecase/` | Usecases injectables : `ProgrammerAlarmeUseCase`, `GererNotificationsUseCase`, `GererPermissionsNotificationUseCase`. Retour `Either<Failure, T>` (dartz). |
| `data/repository/` | Implémentations des contrats (`*RepositoryImpl`), transformation en `Failure` des erreurs techniques. |
| `data/service/local/` | `NotificationLocalService` : unique point de contact avec `flutter_local_notifications` + `timezone` (mode exact Android, canaux, payloads). |
| `service/` | `AlarmeNotificationService` : initialisation de l'app, arrêt / nettoyage, et **routage des actions** (clic sur une notification → payload décodé → callback `onNotificationTapped` de la feature). |

### Flux du module

```
Feature (BLoC)                        ← n'importe quelle feature
   ↓ usecase injecté
ProgrammerAlarmeUseCase / GererNotificationsUseCase (domaine)
   ↓ contrat
AlarmeRepository / NotificationRepository (contrat)
   ↑ implémenté par
AlarmeRepositoryImpl / NotificationRepositoryImpl (data)
   ↓
NotificationLocalService → flutter_local_notifications (Android + iOS)
```

Côté interactions : plugin → `AlarmeNotificationService._gererReponse` →
`payload` décodé → `onNotificationTapped` (régistré par la feature qui
navigue, via go_router).

### Intégration

1. Dans `main.dart`, après `configureDependencies()` :
   `await getIt<AlarmeNotificationService>().initialiser();`
2. Pour pouvoir déclencher des alarmes / notifications, s'assurer que
   `EtatPermission.complet` est vrai (sinon utiliser
   `GererPermissionsNotificationUseCase(demander: true)`).
3. Permissions natives déjà présentes : Android `POST_NOTIFICATIONS`
   (+ `SCHEDULE_EXACT_ALARM` pour les alarmes exactes, Android 12+) ;
   iOS : autorisations alert/badge/sound demandées par le module.

### Comportement "app fermée" / reboot

- **App en arrière-plan ou fermée (process vivant mort)** : l'alarme est
  enregistrée dans l'OS (`zonedSchedule` exact + `matchDateTimeComponents`
  pour les occurrences hebdo) → elle sonne à l'heure prévue sans l'app.
- **Tap sur la notification quand l'app était fermée (cold start)** :
  `getNotificationAppLaunchDetails` est lu pendant [initialiser] ; le payload
  est exposé via `AlarmeNotificationService.payloadDeLancement` et
  `onNotificationTapped` est appelé → la feature peut naviguer dès le
  premier frame.
- **Redémarrage du téléphone** : les alarmes **ponctuelles** sont effacées
  par Android au reboot ; elles sont donc **persistées** par
  `AlarmePersistanceService` (shared_preferences) et **re-programmées
  automatiquement** à chaque `initialiser()`. Les alarmes répétées sont
  recréées par l'OS (`matchDateTimeComponents`).

### Intégration avec le reboot natif (optionnel, avancé)

Sur Android, la re-programmation n'a lieu qu'à la **première ouverture** de
l'app après reboot. Pour rescheduler pendant que l'appareil redémarre (sans
ouvrir l'app), il faudrait un récepteur natif `BOOT_COMPLETED` + plugin
personnalisé — hors périmètre de ce module pour l'instant.


