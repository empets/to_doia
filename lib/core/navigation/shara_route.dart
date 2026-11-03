/// ── Registre des routes Shara ────────────────────────────────────────────────
///
/// Source de vérité unique de la navigation : le routing UI (boutons,
/// barre du bas) ET la navigation vocale de Shara utilisent le MÊME
/// mapping destination → route.
///
/// ⚠️ Pour ajouter une route :
///  1. définir son chemin ci-dessous,
///  2. l'ajouter dans [ SharaRouter ] (shara_router.dart),
///  3. l'ajouter dans [SharaRoute.pathForDestination] (alias compris !),
///  4. l'ajouter aux prompts système dans
///     `groq_remote_data_soucre.dart` (`chat()` et `interact()`),
///  5. documenter la destination dans `SHARA_ROUTES.md`.

class SharaRoute {
  SharaRoute._();

  // ── Démarrage ──────────────────────────────────────────────────────────────
  static const String splash = '/splash';
  static const String permissions = '/permissions';

  // ── Onglets (StatefulShellRoute — barre du bas) ────────────────────────────
  static const String home = '/home';
  static const String tasks = '/tasks';
  static const String settings = '/settings';

  // ── Flux tâche ─────────────────────────────────────────────────────────────
  static const String manualCreate = '/manual-create';
  static const String listening = '/listening';
  static const String transcription = '/transcription';
  static const String analyzing = '/analyzing';
  static const String confirmation = '/confirmation';
  static const String success = '/success';

  // ── Divers ─────────────────────────────────────────────────────────────────
  static const String simulationAlarme = '/simulation-alarme';

  // ── Sous-écrans Paramètres ─────────────────────────────────────────────────
  static const String settingsAppearance = '/settings/appearance';
  static const String settingsLanguage = '/settings/language';
  static const String settingsNotifications = '/settings/notifications';
  static const String settingsVoice = '/settings/voice';
  static const String settingsData = '/settings/data';
  static const String settingsAbout = '/settings/about';
  static const String settingsHelp = '/settings/help';

  /// Mapping destination Shara (normalisée : trim, lowercase,
  /// espaces/tirets → `_`) → chemin go_router.
  ///
  /// Utilisé par [SharaNav.navigate] — identique pour la voix et l'UI.
  static final Map<String, String> pathForDestination = {
    // Navigation principale
    'home': home,
    'accueil': home,
    'ouvrir_accueil': home,
    'tasks': tasks,
    'taches': tasks,
    'mes_taches': tasks,
    'liste_taches': tasks,
    'settings': settings,
    'parametres': settings,

    // Création de tâche
    'create_task': manualCreate,
    'creer_tache': manualCreate,
    'nouvelle_tache': manualCreate,
    'creation_tache': manualCreate,

    // Flux vocal
    'voice': listening,
    'listening': listening,
    'ecouter': listening,
    'enregistrer': listening,
    'transcription': transcription,

    // Flux d'une tâche en attente (vérifs dans SharaNav)
    'analyzing': analyzing,
    'analyse': analyzing,
    'confirmation': confirmation,
    'confirmer': confirmation,
    'confirmer_tache': confirmation,
    'success': success,
    'succes': success,

    // Divers
    'simulation_alarme': simulationAlarme,
    'alarmes': simulationAlarme,

    // Sous-écrans Paramètres
    'settingsappearance': settingsAppearance,
    'settingsapparence': settingsAppearance,
    'appearance': settingsAppearance,
    'apparence': settingsAppearance,
    'settingslanguage': settingsLanguage,
    'settingslangue': settingsLanguage,
    'language': settingsLanguage,
    'langue': settingsLanguage,
    'settingsnotifications': settingsNotifications,
    'settingsnotification': settingsNotifications,
    'notifications': settingsNotifications,
    'notification': settingsNotifications,
    'voice_settings': settingsVoice,
    'settingsvoice': settingsVoice,
    'parametres_vocaux': settingsVoice,
    'settingsdata': settingsData,
    'data': settingsData,
    'donnees': settingsData,
    'settingsabout': settingsAbout,
    'about': settingsAbout,
    'a_propos': settingsAbout,
    'settingshelp': settingsHelp,
    'aide': settingsHelp,
  };

  /// Onglets principaux (0 = home, 1 = tasks, 2 = settings) — voir
  /// `SharaNavShell`.
  static const List<String> tabs = [home, tasks, settings];
}
