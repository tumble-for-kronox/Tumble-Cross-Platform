import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tumble/core/api/work_manager/background_task.dart';
import 'package:tumble/core/app.dart';
import 'package:tumble/core/shared/app_dependencies.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.initialize();
  await getIt<AppDependencies>().initialize();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const App());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
