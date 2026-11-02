import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grace_church/core/alarme_notification/presentation/pages/simulation_alarme_page.dart';
import 'package:grace_church/core/alarme_notification/service/alarme_notification_service.dart';
import 'package:grace_church/core/constante/global_params.dart';
import 'package:grace_church/core/injetction/injection_container.dart';
import 'package:grace_church/core/observer/observer.dart';
import 'package:grace_church/core/constante/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  

  // ⚠️ SÉCURITÉ : toutes les clés viennent de --dart-define-from-file=env.json.
  // Aucune valeur secrète n'est écrite en dur dans le code. Vérification
  // explicite pour échouer avec un message clair si la configuration manque.
  GlobalParams.validateFirebaseConfiguration();

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: GlobalParams.apiKey,
      appId: GlobalParams.appId,
      messagingSenderId: GlobalParams.messagingSenderId,
      projectId: GlobalParams.projectId,
      storageBucket: GlobalParams.storageBucket,
    ),
  );
  Bloc.observer = SimpleBlocObserver();
  await configureDependencies();
  // Module alarme/notification : init unique (plugin OS + re-programmation
  // des alarmes persistées après reboot).
  await getIt<AlarmeNotificationService>().initialiser();

  // ⚠️ MODE SIMULATION TEMPORAIRE : l'app démarre sur la page
  // de simulation du module alarme/notification.
  // Pour revenir à l'app normale : remplacer la ligne par `runApp(const SmartReminderApp());`
  // et réactiver les imports ci-dessous.
  debugPrint('🧪 AlarmeNotificationService initialisé, payload de lancement: '
      '${getIt<AlarmeNotificationService>().payloadDeLancement}');

  runApp(const _AppSimulationAlarme());
}

/// Wrapper temporaire : lance l'app sur la page de simulation.
class _AppSimulationAlarme extends StatelessWidget {
  const _AppSimulationAlarme();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SimulationAlarmePage(),
    );
  }
}
