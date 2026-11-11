---
name: to-doia-dev
description: Conventions et architecture du projet Flutter to_doia (app to-do avec assistant IA "Shara"). Utiliser cette skill DÈS QU'ON TRAVAILLE DANS CE PROJET : ajouter une feature, créer/modifier un usecase, repository, BLoC, entité freezed, module partagé dans lib/core, injection de dépendances, alarmes/notifications. à beaucoup de déclencheurs même implicites, car tout le code de ce repo doit suivre ces conventions.
---

# to_doia — Conventions de développement

Application **Flutter** (to-do list + assistant IA « Shara ») en **Clean Architecture
modulaire**. Ce document décrit COMMENT implémenter chaque couche. Respecter les
noms de dossiers existants (avec leurs fautes volontaires) : `domaine/`,
`repositorie/`, `usecase/`, `injetction/`, `custome_widget/`.

## Structure du projet

```
lib/
├── main.dart          # point d'entrée
├── core/              # couche PARTAGÉE par toutes les features
│   ├── alarme_notification/   # module centralisé alarmes/notifications (feature-agnostic)
│   ├── injetction/    # get_it + injectable (injection_container.dart)
│   ├── service_systeme/  # error/failure, usercase/ (contrat UseCase), formz, api
│   ├── custome_widget/, constante/, extention/, alert/, voice/, transcription/, ...
├── feature/           # une fonctionnalité = data / domaine / presentation
│   ├── home/          # accueil, création de tâche (manuelle + vocale + IA Groq)
│   ├── taches/        # liste, détail, création manuelle
│   ├── assistant/     # écran Shara
│   ├── onboarding/, setting/
└── gen/               # code généré — NE JAMAIS MODIFIER
```

Règles de dépendances :
- `presentation` ne connaît que le `domaine` (les usecases), jamais `data`.
- `data` implémente les contrats du `domaine`.
- Le montage se fait dans `lib/core/injetction/injection_container.dart` (annotations injectable, config générée).
- Les clés API (Groq) viennent de `env.json`, injectées au build via `run.sh` (`--dart-define-from-file=env.json`).
- Fichiers `*.freezed.dart`, `*.g.dart`, `injection_container.config.dart` : générés par
  `dart run build_runner build --delete-conflicting-outputs`. Ne jamais les éditer à la main.

## Flux d'une fonctionnalité

```
UI (presentation/page + widget)
   ↓ événement
BLoC (presentation/bloc)          ← état de l'écran
   ↓ appelle
UseCase (domaine/usecase)         ← logique métier
   ↓ contrat
Repository (domaine/repositorie)  ← interface abstraite
   ↑ implémentée par
RepositoryImpl (data/repository)
   ↓
Service local (sqflite) ou remote (API / Groq IA)
```

## Comment implémenter chaque couche

### 1. Request / Response (domaine)

Entités freezed dans `feature/<x>/domaine/entities/request/` et `.../response/` :

```dart
@freezed
abstract class RequestMonObjet with _$RequestMonObjet {
  factory RequestMonObjet({
    required String title,
    @Default("") String id,
  }) = _RequestMonObjet;

  factory RequestMonObjet.fromJson(Map<String, dynamic> json) =>
      _$RequestMonObjetFromJson(json);
}
```

Puis `dart run build_runner build --delete-conflicting-outputs`.

### 2. Repository (contrat, domaine)

Dans `domaine/repositorie/`, classe **abstraite**, retourne toujours
`Either<Failure, T>` (dartz). Commenter chaque méthode (dans le style du code existant,
en français) :

```dart
abstract class MonRepository {
  /// cette interface permet de faire X
  /// il prend en paramètre un objet RequestX
  /// il retourne Either<Failure, ResponseX>
  Future<Either<Failure, ResponseX>> faireQuelqueChose(RequestX request);
}
```

### 3. UseCase (domaine)

Dans `domaine/usecase/`, un fichier par cas d'usage, `@lazySingleton` :

```dart
@lazySingleton
class FaireQuelqueChoseUseCase implements UseCase<ResponseX, RequestX> {
  const FaireQuelqueChoseUseCase(this._repository);
  final MonRepository _repository;

  @override
  Future<Either<Failure, ResponseX>> call(RequestX request) =>
      _repository.faireQuelqueChose(request);
}
```

Le contrat de base est `lib/core/service_systeme/usercase/usercase.dart`
(`UseCase<Type, Params>` — `Future<Either<Failure, Type>> call(Params params)` ;
`EmptyRequest` si pas de paramètre).

### 4. RepositoryImpl (data)

Dans `data/repository/` : implémente le contrat, transforme les erreurs techniques
en `Failure` ( voir `lib/core/service_systeme/error/` et `lib/core/data_process/`).
Les sources de données sont dans `data/service/local/` (sqflite) et
`data/service/remote/` (API / Groq).

### 5. BLoC (presentation)

Dans `presentation/bloc/<nom>/` : événements **sealed** dans `event/`, état dans
`state/`, BLoC avec `switch (event)` et pattern matching `case MonEvent(:final champ)`. 

- La validation visuelle utilise **Formz** (`TextFormz.dirty(...)`,
  `Formz.validate([...])`, `FormzSubmissionStatus` pour `status`).
- Champ modifié → `emit(state.copyWith(champ: input, isValide: _validate(...)))`.
- Soumission → `inProgress`, appelle les usecases, puis `fold` :
  - `failure` → `emit(state.copyWith(errorMessage: failure.message, status: failure))`
  - `success` → effet de bord (ex : programmer le rappel) puis `status: success`.
- Les effets de bord (alarmes, navigation) ne se déclenchent QUE si l'API a réussi.

### 6. Injection

Annoter les classes (`@lazySingleton`, `@injectable`, `@LazySingleton(as: Contrat)`)
puis régénérer `injection_container.config.dart` avec build_runner. Consommer via
`getIt<MonUseCase>()`, jamais en construisant à la main.

## Module partagé (lib/core)

Un module réutilisable (ex : `alarme_notification`) suit lui aussi la Clean
Architecture (`domaine/`, `data/`, `service/`) et est **feature-agnostic** :
les features ne l'utilisent QUE via ses usecases injectés. Ne jamais coder la
logique d'alarme/notification en doublon dans une feature.

## Imports

⚠️ Les imports du projet utilisent le préfixe `package:grace_church/...`
(hérité d'anciens fichiers) — suivre le style existant du fichier ouvert ;
vérifier le nom du package déclaré dans `pubspec.yaml` (champ `name:`) pour les
nouveaux fichiers et rester cohérent avec les imports du fichier modifié.

## Langue et style

- Dossiers, noms de classes, commentaires et docs en **français** (entités en
  `Entite`, méthodes en français quand c'est privé/intérieur).
- Docstrings/commentaires au-dessus des interfaces et méthodes clés.
- Ne pas modifier `build/`, `lib/gen/`, `.dart_tool/`.
