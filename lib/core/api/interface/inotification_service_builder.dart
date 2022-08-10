import 'package:flutter/foundation.dart';

@immutable
abstract class INotificationServiceBuilder {
  Future<bool> buildNotificationChannel({
    required String channelGroupKey,
    required String channelKey,
    required String channelName,
    required String channelDescription,
  });
  Future<bool> buildNotification(
      {required int id,
      required String channelKey,
      required String groupkey,
      required String title,
      required String body,
      required DateTime date});
}
