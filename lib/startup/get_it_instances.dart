import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/api/repository/backend_repository.dart';
import 'package:tumble/api/repository/implementation_repository.dart';
import 'package:tumble/api/repository/user_repository.dart';
import 'package:tumble/database/database.dart';
import 'package:tumble/database/repository/database_repository.dart';
import 'package:tumble/theme/repository/theme_repository.dart';

final GetIt locator = GetIt.instance;

Future<void> initSingletons() async {
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  locator.registerLazySingleton(() => secureStorage);
  locator.registerLazySingleton(() => BackendRepository());
  locator.registerLazySingleton(() => DatabaseRepository());
  locator.registerLazySingleton(() => AppDatabase());
  locator.registerLazySingleton(() => ImplementationRepository());
  locator.registerLazySingleton(() => UserRepository());
  locator.registerLazySingleton(() => sharedPref);
  locator.registerLazySingleton(() => ThemeRepository());
}
