/// Configuration centralisée de l'application.
///
/// ⚠️ SÉCURITÉ — RÈGLE ABSOLUE :
/// Aucune clé d'API, aucun secret et aucun identifiant sensible ne doit être
/// écrit en dur dans ce fichier (ni ailleurs dans `lib/`).
///
/// Toutes les valeurs proviennent de `--dart-define` (ou de
/// `--dart-define-from-file=env.json`), ce qui permet de garder `env.json`
/// hors du dépôt Git (voir `.gitignore`).
///
/// Lancement en local :
///   cp env.example.json env.json      # puis renseigner les valeurs
///   flutter run --dart-define-from-file=env.json
///
/// Build release :
///   flutter build apk --release --dart-define-from-file=env.json
///
/// ⚠️ LIMITE IMPORTANTE :
/// `--dart-define` compile la valeur dans le binaire. Elle reste donc
/// extractible par un utilisateur motivé. Pour la production, la clé Groq
/// doit être déplacée côté serveur (Cloud Function / proxy backend) et ne
/// jamais être appelée directement depuis l'application.
class GlobalParams {
  GlobalParams._();

  // ---------------------------------------------------------------------------
  // Firebase
  // ---------------------------------------------------------------------------
  /// Identifiants Firebase, injectés au build.
  /// Voir `env.example.json` pour la liste complète des variables attendues.
  static const String apiKey = String.fromEnvironment('FIREBASE_API_KEY');
  static const String appId = String.fromEnvironment('FIREBASE_APP_ID');
  static const String messagingSenderId = String.fromEnvironment(
    'FIREBASE_MESSAGING_SENDER_ID',
  );
  static const String projectId = String.fromEnvironment('FIREBASE_PROJECT_ID');
  static const String storageBucket = String.fromEnvironment(
    'FIREBASE_STORAGE_BUCKET',
  );

  // ---------------------------------------------------------------------------
  // Supabase (non utilisé pour l'instant — conservé pour la configuration)
  // ---------------------------------------------------------------------------
  static const String supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
  );

  // ---------------------------------------------------------------------------
  // Groq
  // ---------------------------------------------------------------------------
  /// Clé Groq injectée au build.
  ///
  /// ⚠️ La clé qui était historiquement codée en dur dans
  /// `groq_remote_data_soucre.dart` a été exposée dans le dépôt Git :
  /// elle DOIT être révoquée depuis la console Groq, même après sa suppression
  /// du code. Une clé publiée reste compromise pour toujours.
  ///
  /// ⚠️ À terme, cette clé ne doit plus être présente dans l'app :
  /// les appels doivent passer par un proxy backend qui ajoute l'en-tête
  /// `Authorization: Bearer ...` côté serveur.
  static const String groqApiKey = String.fromEnvironment('GROQ_API_KEY');

  static const String userRealBdPath = "users";

  /// Version de l'application jointe aux diagnostics (retours utilisateur).
  static const String appVersion = '1.0.0';

  /// Vérifie que la configuration indispensable au démarrage est présente.
  ///
  /// Objectif : échouer immédiatement avec un message clair au lieu de laisser
  /// Firebase s'initialiser avec des valeurs vides et produire une erreur
  /// incompréhensible. La clé Groq n'est volontairement pas vérifiée ici :
  /// elle n'est nécessaire qu'au moment d'un appel vocal, et l'application
  /// peut démarrer sans (le flux vocal affichera alors une erreur explicite).
  static void validateFirebaseConfiguration() {
    final missing = <String>[
      if (apiKey.isEmpty) 'FIREBASE_API_KEY',
      if (appId.isEmpty) 'FIREBASE_APP_ID',
      if (messagingSenderId.isEmpty) 'FIREBASE_MESSAGING_SENDER_ID',
      if (projectId.isEmpty) 'FIREBASE_PROJECT_ID',
      if (storageBucket.isEmpty) 'FIREBASE_STORAGE_BUCKET',
    ];

    if (missing.isNotEmpty) {
      throw StateError(
        'Configuration Firebase manquante : ${missing.join(', ')}.\n'
        'Créez un fichier env.json à partir de env.example.json, '
        'renseignez les valeurs, puis lancez :\n'
        '  flutter run --dart-define-from-file=env.json\n'
        'Ne commitez jamais env.json (il est ignoré par Git).',
      );
    }
  }

  static const String poliqueOfConfidentialite =
      "leniti atque corrupti quos dolores et quas molestias excepturi sint voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint Praesent euismod, urna in tincidunt gravida, lectus lorem tincidunt justo, nec dignissim neque erat nec magna. Suspendisse potenti. voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint  voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint  voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint  voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint Curabitur eget mauris non ipsum fermentum volutpat. Integer vitae lectus at orci varius interdum. Nulla facilisi. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Donec nec nisi sed lacus facilisis aliquet. Aliquam erat volutpat. Morbi feugiat, ipsum at facilisis elementum, est magna commodo nulla, sed fermentum lorem sem non odio. Phasellus euismod purus ut mi dignissim, sed dictum lacus vestibulum. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.  Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam  aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur.At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium";
}
