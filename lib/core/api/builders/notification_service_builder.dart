import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/interface/inotification_service_builder.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/theme/data/colors.dart';

class NotificationServiceBuilder implements INotificationServiceBuilder {
  final Color defaultColor = CustomColors.orangePrimary;
  final String defaultIcon = "resource://drawable/res_tumble_app_logo";
  final _awesomeNotifications = getIt<AwesomeNotifications>();

  /// Build notification channel dynamically
  @override
  NotificationChannel buildNotificationChannel({
    required String channelKey, // Schedule ID
    required String channelName, // name of schedule in readable text
    required String channelDescription, // short description passed to navigator
  }) =>
      NotificationChannel(
        channelKey: channelKey,
        channelName: channelName,
        channelDescription: channelDescription,
        defaultColor: defaultColor,
      );

  /// Build notification with required params according
  /// to app context dynamically
  @override
  Future<bool> buildNotification(
          {required int id,
          required String channelKey,
          required String groupkey,
          required String title,
          required String body,
          required DateTime date}) =>
      _awesomeNotifications.createNotification(
          content: NotificationContent(
              id: id,
              channelKey: channelKey, // Schedule id
              groupKey: groupkey, //Schedule course
              title: title,
              icon: defaultIcon,
              color: defaultColor,
              body: body,
              wakeUpScreen: true,
              notificationLayout: NotificationLayout.Default,
              category: NotificationCategory.Reminder),
          actionButtons: [
            NotificationActionButton(key: 'VIEW', label: 'View'),
          ],
          schedule: NotificationCalendar.fromDate(
              date: date
                  .subtract(Duration(
                      minutes: getIt<SharedPreferences>()
                          .getInt(PreferenceTypes.notificationOffset)!))
                  .toUtc(),
              allowWhileIdle: true,
              preciseAlarm: true));

  @override
  Future<bool> initializeAllNotificationChannels() {
    // TODO: implement initializeAllNotificationChannels
    throw UnimplementedError();
  }

  /* void updateNotificationChannelKeys() {
  List<NotificationChannel> notificationChannels = [];
  ScheduleRepository.getAllDatabaseScheduleNames().then((rowNames) {
    if (rowNames != null) {
      for (var rowName in rowNames) {
        notificationChannels.add(NotificationChannel(
          channelKey: rowName.scheduleId,
          channelName: '${rowName.scheduleId} notifications',
          channelDescription: 'Channel for ${rowName.scheduleId} notifications',
          defaultColor: CustomColors.lightColors.secondary,
          importance: NotificationImportance.High,
        ));
        AwesomeNotifications().initialize(
            "resource://drawable/res_tumble_app_logo", notificationChannels);
        log('Updated notification channels to ${notificationChannels.toString()}');
      }

      /// This extra addition should be commented out in production build.
      /* notificationChannels.add(NotificationChannel(
        channelKey: 'testing',
        channelName: 'channel for testing',
        channelDescription: 'Notification channel meant to be used for testing',
        defaultColor: CustomColors.lightColors.secondary,
        importance: NotificationImportance.High,
      )); */

    }
  });
} */
}
