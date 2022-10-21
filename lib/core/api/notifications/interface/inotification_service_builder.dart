import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class INotificationServiceBuilder {
  NotificationChannel buildNotificationChannel({
    required String channelKey,
    required String channelName,
    required String channelDescription,
  });

  Future<bool> buildOffsetNotification(
      {required int id,
      required String channelKey,
      required String groupkey,
      required String title,
      required String body,
      required DateTime date});

  Future<bool> buildExactNotification(
      {required int id,
      required String channelKey,
      required String groupkey,
      required String title,
      required String body,
      required DateTime date});
}
