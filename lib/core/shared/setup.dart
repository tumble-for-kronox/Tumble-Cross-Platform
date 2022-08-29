import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/shared/view_types.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';

void setupRequiredSharedPreferences() {
  final sharedPrefs = getIt<SharedPreferences>();

  final possibleTheme = sharedPrefs.getString(PreferenceTypes.theme);
  final possibleView = sharedPrefs.getInt(PreferenceTypes.view);
  final possibleNotification =
      sharedPrefs.getInt(PreferenceTypes.notificationTime);
  final possibleSchool = sharedPrefs.getString(PreferenceTypes.school);
  final possibleAutoSignup = sharedPrefs.getBool(PreferenceTypes.autoSignup);

  /// Check if previously attempted fetches are null, assign accordingly
  sharedPrefs.setString(PreferenceTypes.theme, possibleTheme ?? 'system');
  log(getIt<SharedPreferences>().getString(PreferenceTypes.theme)!);

  sharedPrefs.setInt(
      PreferenceTypes.view, possibleView ?? ScheduleViewTypes.list);
  sharedPrefs.setInt(
      PreferenceTypes.notificationTime, possibleNotification ?? 60);
  sharedPrefs.setBool(PreferenceTypes.autoSignup, possibleAutoSignup ?? false);
  possibleSchool == null
      ? null
      : sharedPrefs.setString(PreferenceTypes.school, possibleSchool);
  sharedPrefs.getStringList(PreferenceTypes.bookmarks) == null
      ? sharedPrefs.setStringList(PreferenceTypes.bookmarks, <String>[])
      : null;
}
