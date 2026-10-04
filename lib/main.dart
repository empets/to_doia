import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grace_church/core/constante/global_params.dart';
import 'package:grace_church/core/injetction/injection_container.dart';
import 'package:grace_church/core/observer/observer.dart';
import 'package:grace_church/feature/home/overview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
  await configureDependencies();
  runApp(const SmartReminderApp());
}
