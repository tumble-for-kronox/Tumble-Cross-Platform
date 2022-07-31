import 'package:flutter/material.dart';
import 'package:tumble/core/app.dart';
import 'package:tumble/core/shared/setup.dart';
import 'package:tumble/core/startup/get_it_instances.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSingletons();
  setupRequiredSharedPreferences();
  setupKronoxSession();
  runApp(const App());
}
