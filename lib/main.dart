import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_doia/core/injetction/injection_container.dart';
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
  runApp(const SmartReminderApp());
}
