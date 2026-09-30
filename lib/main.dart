import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_doia/feature/home/overview.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const SmartReminderApp());
}
