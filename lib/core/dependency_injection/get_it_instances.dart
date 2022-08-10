import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/repository/backend_repository.dart';
import 'package:tumble/core/api/repository/cache_and_interaction_repository.dart';
import 'package:tumble/core/api/repository/notification_repository.dart';
import 'package:tumble/core/api/repository/user_repository.dart';
import 'package:tumble/core/database/database.dart';
import 'package:tumble/core/database/repository/database_repository.dart';
import 'package:tumble/core/database/repository/secure_storage_repository.dart';
import 'package:tumble/core/theme/repository/theme_repository.dart';

final GetIt getIt = GetIt.instance;

class DependencyInjection {
  /// Initialize dependency injection
  static Future<void> initSingletons() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    getIt.registerLazySingleton(() => sharedPref);
    getIt.registerLazySingleton(() => SecureStorageRepository());
    getIt.registerLazySingleton(() => BackendRepository());
    getIt.registerLazySingleton(() => AppDatabase());
    getIt.registerLazySingleton(() => DatabaseRepository());
    getIt.registerLazySingleton(() => ThemeRepository());
    getIt.registerLazySingleton(() => CacheAndInteractionRepository());
    getIt.registerLazySingleton(() => UserRepository());
    getIt.registerLazySingleton(() => NotificationRepository());
    getIt.registerLazySingleton(() => AwesomeNotifications());
  }
}
