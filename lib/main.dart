import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_doia/core/constante/global_params.dart';
import 'package:to_doia/core/injetction/injection_container.dart';
import 'package:to_doia/core/observer/observer.dart';
import 'package:to_doia/feature/home/overview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await initVoiceTask();
  await configureDependencies();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
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
  runApp(const SmartReminderApp());
}
