import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:tumble/core/api/notifications/repository/notification_repository.dart';
import 'package:tumble/core/api/shared_preferences/shared_preference_service.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/theme/data/theme_strings.dart';

class AppDependencies {
  /// Initializes preferences and notification channels for user.
  /// Application depends on these preference values.

  Future<void> updateDependencies(String schoolName) async {
    final preferenceService = getIt<SharedPreferenceService>();

    /// Only initialize notifications if notifications are allowed by user
    if (preferenceService.allowedNotifications != null &&
        preferenceService.allowedNotifications!) {
      await getIt<NotificationService>().initialize();
    }
    preferenceService.setBookmarks(<String>[]);
    preferenceService.setSchool(schoolName);
  }

  Future<void> initialize() async {
    final preferenceService = getIt<SharedPreferenceService>();
    final awesomeNotifications = getIt<AwesomeNotifications>();
    final notificationService = getIt<NotificationService>();

    // Set default theme to system if it is not already set
    preferenceService.setTheme(preferenceService.theme ?? ThemeType.system);

    // Set default notification offset to 60 if it is not already set
    preferenceService
        .setNotificationOffset(preferenceService.notificationOffset ?? 60);

    // Set default auto signup to false if it is not already set
    preferenceService.setAutoSignup(preferenceService.autoSignup ?? false);

    // Initialize the notification service
    notificationService.initialize();

    // Check if the user's preference for notifications matches the current permission
    if (preferenceService.allowedNotifications != null &&
        await awesomeNotifications.isNotificationAllowed() !=
            preferenceService.allowedNotifications) {
      // Get the current permission for notifications
      final bool permissionType =
          await awesomeNotifications.isNotificationAllowed();

      // Update the user's preference for notifications
      preferenceService.setNotificationAllowed(permissionType);

      // If notifications have been disabled, cancel all scheduled notifications
      if (!permissionType) {
        log(name: 'app_dependencies', "Cancelling all user notifications..");
        notificationService.cancelAllNotifications();
      }
      log(
          name: 'app_dependencies',
          "Changing permission for notifications to be ${permissionType ? 'allowed' : 'not allowed'}..");
    }

    // Set the bookmarks to an empty list if they have not been set yet
    if (preferenceService.bookmarkIds == null) {
      preferenceService.setBookmarks(<String>[]);
    }
  }
}
