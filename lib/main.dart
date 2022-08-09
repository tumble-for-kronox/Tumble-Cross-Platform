import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tumble/core/api/work_manager/background_task.dart';
import 'package:tumble/core/app.dart';
import 'package:tumble/core/shared/setup.dart';
import 'package:tumble/core/startup/get_it_instances.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSingletons();
  setupRequiredSharedPreferences();
  Workmanager().initialize(
      BackgroundTask.callbackDispatcher,
      isInDebugMode: true
  );
  Workmanager().registerPeriodicTask(
    BackgroundTask.identifier, BackgroundTask.name,
    frequency: const Duration(hours: 12),
    constraints: Constraints(
        networkType: NetworkType.connected,
        requiresBatteryNotLow: true,
        requiresCharging: false,
        requiresDeviceIdle: false,
        requiresStorageNotLow: false
    ),
  );
  runApp(const App());
}
