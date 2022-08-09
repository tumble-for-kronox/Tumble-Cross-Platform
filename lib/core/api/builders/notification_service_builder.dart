import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tumble/core/startup/get_it_instances.dart';
import 'package:tumble/core/theme/data/colors.dart';

class NotificationServiceBuilder {
  final Color defaultColor = CustomColors.orangePrimary;
  final String defaultIcon = 'assets/images/tumbleAppLogo.png';
  final _awesomeNotifications = getIt<AwesomeNotifications>();

  /// Build notification channel dynamically
  Future<bool> buildNotificationChannel({
    required String channelGroupKey, // Specific schedule course
    required String channelKey, // Schedule ID
    required String channelName, // name of schedule in readable text
    required String channelDescription, // short description passed to navigator
  }) =>
      _awesomeNotifications.initialize(
          defaultIcon,
          [
            NotificationChannel(
              channelGroupKey: channelGroupKey,
              channelKey: channelKey,
              channelName: channelName,
              channelDescription: channelDescription,
              defaultColor: defaultColor,
            )
          ],
          debug: kDebugMode);

  /// Build notification with required params according
  /// to app context dynamically
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
              date: date, allowWhileIdle: true, preciseAlarm: true));
}
