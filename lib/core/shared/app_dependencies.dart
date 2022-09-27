import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/repository/notification_repository.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/shared/view_types.dart';
import 'package:tumble/core/theme/data/theme_strings.dart';

class AppDependencies {
  ///
  /// Initializes preferences and notification channels for user.
  /// Application depends on these values.

  Future<void> updateDependencies(String schoolName) async {
    await getIt<NotificationRepository>().initialize();
    final preferenceService = getIt<SharedPreferences>();
    await preferenceService.setStringList(PreferenceTypes.bookmarks, <String>[]);
    await preferenceService.setString(PreferenceTypes.school, schoolName);
  }

  Future<void> initialize() async {
    final preferenceService = getIt<SharedPreferences>();

    preferenceService.setString(
        PreferenceTypes.theme, preferenceService.getString(PreferenceTypes.theme) ?? ThemeType.system);
    preferenceService.setInt(
        PreferenceTypes.view, preferenceService.getInt(PreferenceTypes.view) ?? ScheduleViewTypes.list);
    preferenceService.setInt(
        PreferenceTypes.notificationOffset, preferenceService.getInt(PreferenceTypes.notificationOffset) ?? 60);
    preferenceService.setBool(
        PreferenceTypes.autoSignup, preferenceService.getBool(PreferenceTypes.autoSignup) ?? false);

    /// Checks if the calling function is main() and only set bookmarks to empty
    /// list if bookmarks in Shared Preferences hasn't been set
    if (preferenceService.getStringList(PreferenceTypes.bookmarks) == null) {
      preferenceService.setStringList(PreferenceTypes.bookmarks, <String>[]);
    }
  }
}
