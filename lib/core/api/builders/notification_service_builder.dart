import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/interface/inotification_service_builder.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/theme/data/colors.dart';

///
/// Implementation of [INotificationServiceBuilder] interface,
/// invoking methods which are meant to create a notification
/// at a scheduled time, as well as dynamically allocate channels for
/// invoking any notifications.
///
class NotificationServiceBuilder implements INotificationServiceBuilder {
  final Color defaultColor = CustomColors.orangePrimary;
  final String defaultIcon = "resource://drawable/res_tumble_app_logo";
  final _awesomeNotifications = getIt<AwesomeNotifications>();

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

  @override
  Future<bool> buildOffsetNotification(
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
                  .subtract(Duration(minutes: getIt<SharedPreferences>().getInt(PreferenceTypes.notificationOffset)!))
                  .toUtc(),
              allowWhileIdle: true,
              preciseAlarm: true));

  @override
  Future<bool> buildExactNotification(
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
          schedule: NotificationCalendar.fromDate(date: date, allowWhileIdle: true, preciseAlarm: true));
}
