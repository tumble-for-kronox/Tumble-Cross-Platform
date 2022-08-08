import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/repository/backend_repository.dart';
import 'package:tumble/core/api/repository/implementation_repository.dart';
import 'package:tumble/core/api/repository/user_repository.dart';
import 'package:tumble/core/database/database.dart';
import 'package:tumble/core/database/repository/database_repository.dart';
import 'package:tumble/core/database/repository/secure_storage_repository.dart';
import 'package:tumble/core/theme/repository/theme_repository.dart';

final GetIt locator = GetIt.instance;

Future<void> initSingletons() async {
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPref);
  locator.registerLazySingleton(() => SecureStorageRepository());
  locator.registerLazySingleton(() => BackendRepository());
  locator.registerLazySingleton(() => AppDatabase());
  locator.registerLazySingleton(() => DatabaseRepository());
  locator.registerLazySingleton(() => ThemeRepository());
  locator.registerLazySingleton(() => CacheAndInteractionRepository());
  locator.registerLazySingleton(() => UserRepository());
}
