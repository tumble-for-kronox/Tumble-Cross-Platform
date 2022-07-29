import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/api/apiservices/api_response.dart';
import 'package:tumble/api/repository/user_repository.dart';
import 'package:tumble/database/repository/database_repository.dart';
import 'package:tumble/shared/preference_types.dart';
import 'package:tumble/shared/view_types.dart';
import 'package:tumble/startup/get_it_instances.dart';

import '../database/repository/secure_storage_repository.dart';

void setupRequiredSharedPreferences() {
  final sharedPrefs = locator<SharedPreferences>();

  final possibleTheme = sharedPrefs.getString(PreferenceTypes.theme);
  final possibleView = sharedPrefs.getInt(PreferenceTypes.view);
  final possibleNotification = sharedPrefs.getInt(PreferenceTypes.notificationTime);
  final possibleSchool = sharedPrefs.getString(PreferenceTypes.school);

  /// Check if previously attempted fetches are null, assign accordingly
  sharedPrefs.setString(PreferenceTypes.theme, possibleTheme ?? 'system');
  sharedPrefs.setInt(PreferenceTypes.view, possibleView ?? ScheduleViewTypes.list);
  sharedPrefs.setInt(PreferenceTypes.notificationTime, possibleNotification ?? 60);
  possibleSchool == null ? null : sharedPrefs.setString(PreferenceTypes.school, possibleSchool);
  sharedPrefs.getStringList(PreferenceTypes.favorites) == null
      ? sharedPrefs.setStringList(PreferenceTypes.favorites, <String>[])
      : null;
}
