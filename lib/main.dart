import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tumble/core/app.dart';
import 'package:tumble/core/shared/app_dependencies.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';

void main() async {
  if (kDebugMode) {
    HttpOverrides.global = MyHttpOverrides();
  }

  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.initialize();
  await getIt<AppDependencies>().initialize();
  runApp(const App());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
