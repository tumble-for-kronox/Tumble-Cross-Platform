import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/backend/repository/backend_service.dart';
import 'package:tumble/core/api/backend/repository/cache_service.dart';
import 'package:tumble/core/api/notifications/repository/notification_repository.dart';
import 'package:tumble/core/api/shared_preferences/shared_preference_service.dart';
import 'package:tumble/core/api/database/app_database.dart';
import 'package:tumble/core/api/database/repository/database_service.dart';
import 'package:tumble/core/api/database/repository/secure_storage_service.dart';
import 'package:tumble/core/shared/app_dependencies.dart';
import 'package:tumble/core/theme/repository/theme_repository.dart';

final GetIt getIt = GetIt.instance;

class DependencyInjection {
  /// These are singleton objects created at runtime so that
  /// shared objects share the same reference to a resource.
  static Future<void> initialize() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    getIt.registerLazySingleton(() => AppDependencies());
    getIt.registerLazySingleton(() => sharedPref);
    getIt.registerLazySingleton(() => SecureStorageService());
    getIt.registerLazySingleton(() => BackendService());
    getIt.registerLazySingleton(() => AppDatabase());
    getIt.registerLazySingleton(() => DatabaseService());
    getIt.registerLazySingleton(() => ThemeRepository());
    getIt.registerLazySingleton(() => CacheService());
    getIt.registerLazySingleton(() => NotificationService());
    getIt.registerLazySingleton(() => AwesomeNotifications());
    getIt.registerLazySingleton(() => SharedPreferenceService());
  }
}
