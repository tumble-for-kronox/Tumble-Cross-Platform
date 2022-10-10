import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/notifications/repository/notification_repository.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/theme/data/theme_strings.dart';

class AppDependencies {
  /// Initializes preferences and notification channels for user.
  /// Application depends on these preference values.

  Future<void> updateDependencies(String schoolName) async {
    final preferenceService = getIt<SharedPreferences>();

    /// Only initialize notifications if notifications are allowed by user
    if (preferenceService.getBool(PreferenceTypes.notificationAllowed) != null &&
        preferenceService.getBool(PreferenceTypes.notificationAllowed)!) {
      await getIt<NotificationRepository>().initialize();
    }
    await preferenceService.setStringList(PreferenceTypes.bookmarks, <String>[]);
    await preferenceService.setString(PreferenceTypes.school, schoolName);
  }

  Future<void> initialize() async {
    final preferenceService = getIt<SharedPreferences>();
    final awesomeNotifications = getIt<AwesomeNotifications>();
    final notificationService = getIt<NotificationRepository>();

    preferenceService.setString(
        PreferenceTypes.theme, preferenceService.getString(PreferenceTypes.theme) ?? ThemeType.system);
    preferenceService.setInt(
        PreferenceTypes.notificationOffset, preferenceService.getInt(PreferenceTypes.notificationOffset) ?? 60);
    preferenceService.setBool(
        PreferenceTypes.autoSignup, preferenceService.getBool(PreferenceTypes.autoSignup) ?? false);

    if (preferenceService.getBool(PreferenceTypes.notificationAllowed) != null &&
        await awesomeNotifications.isNotificationAllowed() !=
            preferenceService.getBool(PreferenceTypes.notificationAllowed)) {
      final bool permissionType = await awesomeNotifications.isNotificationAllowed();
      log(
          name: 'app_dependencies',
          "Changing permission for notifications to be ${permissionType ? 'allowed' : 'not allowed'}..");
      preferenceService.setBool(PreferenceTypes.notificationAllowed, permissionType);
      if (!permissionType) {
        log(name: 'app_dependencies', "Cancelling all user notifications ..");
        notificationService.cancelAllNotifications();
      }
    }

    /// Only set bookmarks to empty list if bookmarks
    /// in Shared Preferences hasn't been set
    if (preferenceService.getStringList(PreferenceTypes.bookmarks) == null) {
      preferenceService.setStringList(PreferenceTypes.bookmarks, <String>[]);
    }
  }

  Future<void> setNotifictionPermission(bool value) async {
    final preferenceService = getIt<SharedPreferences>();
    preferenceService.setBool(PreferenceTypes.notificationAllowed, value);
    log(name: 'app_dependencies', "Changing permission for notifications to be ${value ? 'allowed' : 'not allowed'}..");
  }
}
