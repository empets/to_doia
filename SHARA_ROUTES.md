# 🧭 Documentation des routes Shara

> Shara est l'assistante vocale de l'application (barre `SharaAppBar`).
> Ce document décrit **toutes les destinations disponibles à la voix**,
> le flux de création de tâche et les fichiers à modifier pour ajouter une route.

---

## 1. Vue d'ensemble du flux

```
Utilisateur : « Shara, ouvre les tâches »
        │
        ▼
SharaNavigationBloc (chart_whithe_grace.dart)
   🔊 écoute micro → STT → Groq API → TTS
        │  émet SharaNavigationSuccess(SharaResponse)
        ▼
SharaAI (shara_ai.dart) ── listener sur le succès
        │
        ├── action.type == "create_task"  ──►  SharaNav.createTaskFromVoice(task)
        └── action.destination != null    ──►  SharaNav.navigate(destination)
        ▼
SharaNav (shara_nav.dart) ── mapping destination → chemin
        ▼
GoRouter (shara_router.dart) ── go / push vers la route
        ▼
SharaNavShell (barre du bas) ou écran de flux
```

**Règle d'or :** une SEULE source de vérité — le registre
`SharaRoute.pathForDestination` (`lib/core/navigation/shara_route.dart`).
La voix (#Shara) et l'UI (boutons) utilisent le même mapping ; aucun écran
n'appelle `Navigator.push(MaterialPageRoute(...))` vers une page pleine
(réservé aux modales dialogues avec valeur de retour).

### Architecture go_router (fichiers du module `lib/core/navigation/`)

| Fichier | Rôle |
|---|---|
| `shara_route.dart` | Chemins (`/home`, `/tasks`, …) + **mapping destination → chemin** (alias Shara AND UI). |
| `shara_router.dart` | `GoRouter` global (`SharaRouter.i`), routes, branches onglets (barre du bas), gardes « tâche en attente ». |
| `shara_nav.dart` | Façade statique : `navigate(…)`, `go(…)`, `startVoice(…)`, `createTaskFromVoice(…)`, `modifyTask(…)`, `taskConfirmed(…)`, `openManualForm(…)`. Accès sans BuildContext. |
| `shara_nav_shell.dart` | Shell des 3 onglets avec la barre du bas + `SubSettingScaffold` (écrans Paramètres avec bouton retour). |
| `app_flow_controller.dart` | État global : réglages, tâches (simulation), tâche en attente du flux création, type d'action vocal. |

---

## 2. Flux de création de tâche via la voix

> Identique au flux de `VoiceListeningScreen`.

```
« Shara, crée une tâche pour demain 9h, appeler le médecin »
        │
        ▼
Groq API (`interact()`) ──► SharaAction(type: "create_task", task: TaskResponseModel)
        │
        ▼
AppShell._handleSharaCreateTask(TaskResponse)
   • _pendingVoiceTask  = task
   • _pendingActionType = CREATE_TASK
   • _go(AppScreen.analyzing)
        │
        ▼
AIAnalyzingScreen(task, actionType)      ⏳ ~2,2 s d'animation
   onDone → _go(AppScreen.confirmation)
        │
        ▼
ConfirmationScreen(task, actionType)
   ┌─ Modifier   → ManualCreateScreen(task)   (pré-rempli)
   ├─ Confirmer  → FormTastBloc.submit()  → API  → SuccessScreen
   └─ Annuler    → retour Accueil
```

- Shara **ne crée pas** la tâche elle-même : elle prépare la `TaskResponse`
  et la confirme l'utilisateur via `ConfirmationScreen` (création effective
  par `FormTastBloc` → API).
- Sans titre détecté, l'API renvoie `type = none` et Shara pose une question
  de clarification (aucun écran n'est ouvert).

---

## 3. Table des destinations

Normalisation avant mapping : `trim()` + `toLowerCase()` +
espaces et tirets remplacés par `_`.
La correspondance est **stricte** : toute valeur hors liste → alerte info.

### Écrans principaux

| Destination acc. | Alias            | Écran cible (`AppScreen`)      |
|------------------|------------------|--------------------------------|
| `home`           | `accueil`        | Accueil (`_goNav(0)`)          |
| `tasks`          | `taches`, `mes_taches`, `liste_taches` | Tâches (`_goNav(1)`) |
| `settings`       | `parametres`     | Paramètres (`_goNav(2)`)       |
| `create_task`    | `creer_tache`, `nouvelle_tache`, `creation_tache` | Création manuelle |
| `voice`          | `listening`, `ecouter`, `enregistrer` | Écoute vocale |
| `transcription`  | —                | Transcription                  |
| `analyzing`      | `analyse`        | Analyse IA *(1)*               |
| `confirmation`   | `confirmer`, `confirmer_tache` | Confirmation *(1)* |
| `success`        | `succes`         | Écran de succès *(1)*          |

*(1) Nécessite une tâche en attente (`_pendingVoiceTask != null`,
définie par `_handleSharaCreateTask` ou un flux vocal). Sinon : message
d'info « Aucune tâche en attente » — jamais de crash.

### Sous-écrans Paramètres

| Destination acc. | Alias                  | Écran cible                          |
|------------------|------------------------|--------------------------------------|
| `appearance`     | `apparence`            | Apparence                            |
| `language`       | `langue`               | Langue                               |
| `notifications`  | `notification`         | Notifications                        |
| `voice_settings` | `parametres_vocaux`    | Voix et IA                           |
| `data`           | `donnees`              | Données                              |
| `about`          | `a_propos`             | À propos                             |
| `help`           | `aide`                 | Aide                                 |
| `auth`           | `authentification`, `connexion`, `inscription`, `login`, `se_connecter`, `creer_un_compte` | Mon compte (connexion / inscription) |

### ❌ Non exposées à la voix (deliberatenent)

- `splash` — écran de démarrage.
- `permissions` — écran de permissions (réservé au premier lancement).

---

## 4. Performances audio

- Écoute : micro actif, coupure auto après **1,5 s de silence**
  (seuil 0,25) ou **30 s max**.
- Réponse lue par TTS (`fr-FR`, débit 0.5), sortie configurée
  haut-parleur (iOS) / canal navigation (Android).

---

## 5. Où faire évoluer les routes ?

| Fichier | Rôle |
|---------|------|
| `lib/core/navigation/shara_route.dart` | **Registre des destinations** — mapping destination → chemin. Un seul endroit pour ajouter une route. |
| `lib/core/navigation/shara_router.dart` | Déclaration `GoRoute` de l'écran. |
| `lib/core/navigation/shara_nav.dart` | Helper métier s'il y a une pré-condition (ex. tâche en attente). |
| `lib/feature/home/data/service/remote/groq_remote_data_soucre.dart` | Prompts système `chat()` et `interact()` — listes d'écrans connues du modèle. |
| `lib/feature/home/domaine/entities/response/home_responses.dart` | Modèles : `SharaResponse`, `SharaAction` (`.isNavigate`, `.isCreateTask`), `TaskResponseModel`. |

### Ajouter un nouvel écran accessible — checklist

1. Définir le chemin dans `shara_route.dart`.
2. Ajouter le `GoRoute` dans `shara_router.dart`.
3. Ajouter la destination (et ses alias) dans `SharaRoute.pathForDestination`.
4. Ajouter la destination aux deux prompts système de
   `groq_remote_data_soucre.dart`.
5. Documenter la destination dans la table de ce fichier.

---

## 6. Composants de la chaîne — signatures

```dart
// Accès statique sans BuildContext (shara_nav.dart)
SharaNav.navigate('tasks');                    // destination (UI ou voix)
SharaNav.go(SharaRoute.home);                  // chemin direct
SharaNav.startVoice(TypeCreateTaskOrUpdate.CREATE_TASK);   // écoute vocale
SharaNav.createTaskFromVoice(taskResponse);    // analyse IA → confirmation
SharaNav.modifyTask(taskResponse);             // formulaire pré-rempli
SharaNav.taskConfirmed();                      // post-« Confirmer »
SharaNav.openManualForm();                     // formulaire vierge

// Routeur (shara_router.dart)
SharaRouter.i                 // GoRouter (push/go/navigatorKey)
SharaRouter.navigatorKey      // NavigatorState racine
```

**Utilisation dans un écran :**

Les écrans reçoivent des callbacks déjà câblés sur SharaNav par le
routeur (branche Accueil, Tâches, Paramètres) — il n'y a rien à faire :

```dart
// ex. branche Accueil (shara_router.dart)
HomeScreen(
  onNavigate: SharaNav.navigate,
  onCreateTask: SharaNav.createTaskFromVoice,
  ...
)
```

> ⚠️ Modales dialogues avec **valeur de retour** (ex. modale « Modifier »
> de `task_card.dart`) : passer par `SharaRouter.i.push<T>(SharaRoute.manualCreate, extra: ManualCreateArgs(...))`
> — la modale ferme avec `Navigator.pop(context, result)`.

---

*Mise à jour : 03/11/2026 — architecture go_router (module `lib/core/navigation/`), navigation UI et voix unifiée.*
