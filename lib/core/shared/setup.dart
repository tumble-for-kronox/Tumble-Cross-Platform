import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/apiservices/api_response.dart';
import 'package:tumble/core/api/repository/user_repository.dart';
import 'package:tumble/core/database/repository/database_repository.dart';
import 'package:tumble/core/models/api_models/kronox_user_model.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/shared/secure_storage_keys.dart';
import 'package:tumble/core/shared/view_types.dart';
import 'package:tumble/core/startup/get_it_instances.dart';

void setupRequiredSharedPreferences() {
  final sharedPrefs = locator<SharedPreferences>();

  final possibleTheme = sharedPrefs.getString(PreferenceTypes.theme);
  final possibleView = sharedPrefs.getInt(PreferenceTypes.view);
  final possibleNotification =
      sharedPrefs.getInt(PreferenceTypes.notificationTime);
  final possibleSchool = sharedPrefs.getString(PreferenceTypes.school);

  /// Check if previously attempted fetches are null, assign accordingly
  sharedPrefs.setString(PreferenceTypes.theme, possibleTheme ?? 'system');
  sharedPrefs.setInt(
      PreferenceTypes.view, possibleView ?? ScheduleViewTypes.list);
  sharedPrefs.setInt(
      PreferenceTypes.notificationTime, possibleNotification ?? 60);
  possibleSchool == null
      ? null
      : sharedPrefs.setString(PreferenceTypes.school, possibleSchool);
  sharedPrefs.getStringList(PreferenceTypes.favorites) == null
      ? sharedPrefs.setStringList(PreferenceTypes.favorites, <String>[])
      : null;
  if (sharedPrefs.getString(PreferenceTypes.school) != null) {
    log(sharedPrefs.getString(PreferenceTypes.school)!);
  }
}

Future<void> setupKronoxSession() async {
  final secureStorage = locator<FlutterSecureStorage>();
  final databaseStorage = locator<DatabaseRepository>();
  final userRepository = locator<UserRepository>();

  final storedUsername =
      await secureStorage.read(key: SecureStorageKeys.username);
  final storedPassword =
      await secureStorage.read(key: SecureStorageKeys.password);

  if (storedUsername != null && storedPassword != null) {
    ApiResponse<KronoxUserModel?> loggedInUser =
        await userRepository.postUserLogin(storedUsername, storedUsername);

    switch (loggedInUser.status) {
      case ApiStatus.REQUESTED:
        databaseStorage.setUserSession(loggedInUser.data!);
        break;
      default:
        return;
    }
  }
}
