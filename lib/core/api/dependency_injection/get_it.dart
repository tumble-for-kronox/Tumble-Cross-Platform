import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/backend/repository/backend_repository.dart';
import 'package:tumble/core/api/backend/repository/cache_repository.dart';
import 'package:tumble/core/api/notifications/repository/notification_repository.dart';
import 'package:tumble/core/api/preferences/repository/preference_repository.dart';
import 'package:tumble/core/api/database/app_database.dart';
import 'package:tumble/core/api/database/repository/database_repository.dart';
import 'package:tumble/core/api/database/repository/secure_storage_repository.dart';
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
    getIt.registerLazySingleton(() => SecureStorageRepository());
    getIt.registerLazySingleton(() => BackendRepository());
    getIt.registerLazySingleton(() => AppDatabase());
    getIt.registerLazySingleton(() => DatabaseRepository());
    getIt.registerLazySingleton(() => ThemeRepository());
    getIt.registerLazySingleton(() => CacheRepository());
    getIt.registerLazySingleton(() => NotificationRepository());
    getIt.registerLazySingleton(() => AwesomeNotifications());
    getIt.registerLazySingleton(() => PreferenceRepository());
  }
}
