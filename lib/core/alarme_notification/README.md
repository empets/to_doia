# Module centralisé — Alarmes & Notifications

Infrastructure **réutilisable** par toutes les features, **indépendante du
métier**, compatible **Android et iOS**. Documentation complète dans
`architecture/ARCHITECTURE.md` (section « Module centralisé Alarmes & Notifications »).

## Structure

```
alarme_notification/
├── domaine/          # Pur : entités + contrats + usecases (dartz Either)
│   ├── entities/         AlarmeEntite, NotificationProgrammeeEntite, canaux
│   ├── repositorie/      alarme_ / notification_ / permission_ repository
│   └── usecase/          ProgrammerAlarmeUseCase, GererNotificationsUseCase,
│                         GererPermissionsNotificationUseCase
├── data/             # Implémentations techniques
│   ├── repository/       *RepositoryImpl (écrivent les erreurs en Failure)
│   └── service/local/    NotificationLocalService (flutter_local_notifications
│                         + timezone ; seul contact avec les plugins natifs)
└── service/          # Cycle de vie + actions
    └── alarme_notification_service.dart
```

## Utilisation

```dart
// 1. Initialisation (main.dart, après configureDependencies)
await getIt<AlarmeNotificationService>().initialiser();

// 2. Permissions
final etat = await getIt<GererPermissionsNotificationUseCase>()(
  const GererPermissionsNotificationParams(demander: true),
);

// 3. Programmer une alarme (ponctuelle : joursDeRepetition vide)
await getIt<ProgrammerAlarmeUseCase>()(
  ProgrammerAlarmeParams(AlarmeEntite(
    id: 42,
    titre: 'Rappel tâche',
    corps: 'N\'oublie pas ta tâche du jour',
    dateHeure: DateTime(2026, 11, 3, 9, 0),
    joursDeRepetition: const {1: true, 3: true}, // lundi + mercredi
  )),
);

// 4. Notification programmée / locale
await getIt<GererNotificationsUseCase>()(GererNotificationsParams(
  typeOperation: OperationNotification.programmer,
  notification: NotificationProgrammeeEntite(
    id: 7,
    titre: 'Bonjour',
    corps: 'Message',
    dateHeure: DateTime(2026, 11, 3, 18, 30),
  ),
));

// 5. Interactions (clic sur notification) : dans la feature
getIt<AlarmeNotificationService>().onNotificationTapped = (payload) {
  // naviguer via go_router selon payload['route'], etc.
};

// 5b. App OUVERTE par une notification (app précédemment fermée) :
// le callback du point 5 n'est pas encore branché → lire plutôt :
final payloadAuLancement =
    getIt<AlarmeNotificationService>().payloadDeLancement;
```

## App fermée / reboot (automatisé par le module)

- Les alarmes sont **persistées** (`AlarmePersistanceService`,
  shared_preferences) puis **re-programmées à chaque `initialiser()`** :
  une alarme ponctuelle future sonne même après un reboot du téléphone ou
  la fermeture complète de l'app.
- Les alarmes **répétées** utilisent `matchDateTimeComponents:
  dayOfWeekAndTime` (l'OS les refire chaque semaine, sans l'app).
- Purge automatique des alarmes ponctuelles passées, au démarrage.

## Règles

- Aucune feature n'importe `NotificationLocalService` directement : passer
  par les usecases (domaine) uniquement.
- Les ids d'alarme doivent être des entiers positifs < 2^31 (contrainte OS).
- Les ids d'occurrences répétées sont dérivés automatiquement (`id*10 + jour`) ;
  annuler l'alarme de base supprime tout le groupe.




// ===================================.  

 Ce qui a été fait
1. BLoc d'alarme — lib/core/alarme_notification/presentation/bloc/
- alarme_bloc.dart + alarme_event.dart + alarme_state.dart (seald states : Initial / Chargement / Chargée / Erreur)
- Events : VerifiePermissionsAlarme, DemandePermissionsAlarme, ProgrammeAlarme, AnnuleAlarme, AfficheNotification, ChargeAlarmes
- Injecte uniquement les usecases + contrat AlarmeRepository (Clean Architecture respectée)
- (J'ai supprimé un ancien brouillon bloc/event/alarme_event.dart cassé — factory dupliquée + .freezed.dart manquant)
2. Écran de simulation — presentation/pages/simulation_alarme_page.dart avec 6 boutons de test et affichage du cold-start payload.
3. main.dart — initialise AlarmeNotificationService (init + re-programmation post-reboot) et démarre sur la page de simulation (temporaire, ligne commentée à remettre pour l'app normale).
4. flutter analyze → 0 erreur.
🔄 En cours
Le flutter run compile et va installer to_doia sur ton Samsung. Dès qu'il est prêt :
Tu verras la page « Simulation — Alarmes & Notifications »
Test principal : bouton « 2. Programmer une alarme dans 1 minute », puis ferme l'app entièrement (swipe), attaque 1 min, la notification doit sonner, tape-la → l'app redémarre et la carte verte te montre le payload {'route': '/simulation'}.
Je te réponds dès que le run donnera son verdict (build OK ou erreur).
Build · GLM-5.3-Flash Free · 4m 12s · 39.0 tok/s
↳ Shell finished · flutter run --device-id R5CY54LY2ZB --dart-define-from-file=env.json 2>&1
Thought · 5.3s
Ton téléphone n'est plus détecté — il s'est probablement déconnecté (câble, ou téléphone débranché). Le device R5CY54LY2ZB a disparu de la liste.
Pour reprendre :
1. Rebranche le téléphone en USB (ou déverrouille-le si l'écran était verrouillé — Android demande parfois une confirmation USB debugging)
2. Vérifie que l'icône « USB debugging » est toujours active
3. Dis-moi quand c'est fait, je relance flutter run
Si tu es en Wi-Fi / wireless debugging, tu peux aussi le détecter sans câble :
flutter devices --device-timeout 10
…mais SQLite/web ne marchent pas pour notre test — il faut bien le téléphone Android en USB.
Dès que le device est de retour, la simulation se fera dans cet ordre :
1. App ouverte → bouton « 1. Demander les permissions »
2. Bouton « 2. Alarme dans 1 minute »
3. Fermer l'app (swipe)
4. Attendre 1 min → la notification sonne
5. Taper la notification → l'app redémarre → la carte verte affiche le payload 'route' : '/simulation'
Ça validera tout le comportement « app fermée / cold start » du module.