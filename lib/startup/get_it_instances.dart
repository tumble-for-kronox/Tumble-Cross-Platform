import 'package:get_it/get_it.dart';
import 'package:tumble/api/repository/backend_repository.dart';
import 'package:tumble/api/repository/implementation_repository.dart';
import 'package:tumble/database/repository/database_repository.dart';

final GetIt locator = GetIt.instance;

Future<void> initSingletons() async {
  locator.registerLazySingleton(() => BackendRepository());
  locator.registerLazySingleton(() => DatabaseRepository());
  locator.registerLazySingleton(() => ImplementationRepository());
}
