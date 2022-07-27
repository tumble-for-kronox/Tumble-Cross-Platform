import 'dart:ui';

import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/shared/preference_types.dart';
import 'package:tumble/shared/view_types.dart';
import 'package:tumble/startup/get_it_instances.dart';

void setupRequiredSharedPreferences(String schoolName) {
  final sharedPrefs = locator<SharedPreferences>();

  final possibleTheme = sharedPrefs.getString(PreferenceTypes.theme);
  final possibleView = sharedPrefs.getInt(PreferenceTypes.view);
  final possibleNotification =
      sharedPrefs.getInt(PreferenceTypes.notificationTime);

  /// Check dark mode
  final brightness = SchedulerBinding.instance.window.platformBrightness;
  final themeVariant = brightness == Brightness.dark ? 'dark' : 'light';

  /// Check if previously attempted fetches are null, assign accordingly
  sharedPrefs.setString(PreferenceTypes.theme, possibleTheme ?? themeVariant);
  sharedPrefs.setInt(
      PreferenceTypes.view, possibleView ?? ScheduleViewTypes.list);
  sharedPrefs.setInt(
      PreferenceTypes.notificationTime, possibleNotification ?? 60);
  sharedPrefs.setString(PreferenceTypes.school, schoolName);
  sharedPrefs.setStringList(PreferenceTypes.favorites, <String>[]);
}
