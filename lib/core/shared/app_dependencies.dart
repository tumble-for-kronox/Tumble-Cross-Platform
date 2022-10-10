import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/preferences/repository/preference_repository.dart';
import 'package:tumble/core/notifications/repository/notification_repository.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/theme/data/theme_strings.dart';

class AppDependencies {
  /// Initializes preferences and notification channels for user.
  /// Application depends on these preference values.

  Future<void> updateDependencies(String schoolName) async {
    final preferenceService = getIt<PreferenceRepository>();

    /// Only initialize notifications if notifications are allowed by user
    if (preferenceService.allowedNotifications != null && preferenceService.allowedNotifications!) {
      await getIt<NotificationRepository>().initialize();
    }
    preferenceService.setBookmarks(<String>[]);
    preferenceService.setSchool(schoolName);
  }

  Future<void> initialize() async {
    final preferenceService = getIt<PreferenceRepository>();
    final awesomeNotifications = getIt<AwesomeNotifications>();
    final notificationService = getIt<NotificationRepository>();

    preferenceService.setTheme(preferenceService.theme ?? ThemeType.system);
    preferenceService.setNotificationOffset(preferenceService.notificationOffset ?? 60);
    preferenceService.setAutoSignup(preferenceService.autoSignup ?? false);

    if (preferenceService.allowedNotifications != null &&
        await awesomeNotifications.isNotificationAllowed() != preferenceService.allowedNotifications) {
      final bool permissionType = await awesomeNotifications.isNotificationAllowed();
      log(
          name: 'app_dependencies',
          "Changing permission for notifications to be ${permissionType ? 'allowed' : 'not allowed'}..");
      preferenceService.setNotificationAllowed(permissionType);
      if (!permissionType) {
        log(name: 'app_dependencies', "Cancelling all user notifications ..");
        notificationService.cancelAllNotifications();
      }
    }

    /// Only set bookmarks to empty list if bookmarks
    /// in Shared Preferences hasn't been set
    if (preferenceService.bookmarkIds == null) {
      preferenceService.setBookmarks(<String>[]);
    }
  }
}
