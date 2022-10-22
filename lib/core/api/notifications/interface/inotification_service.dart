import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';

@immutable
abstract class INotificationService {
  void updateDispatcher(ScheduleModel newScheduleModel, ScheduleModel oldScheduleModel);

  void assignAllNotificationsWithNewDuration(Duration oldOffset, Duration newOffset);

  void cancelAllNotifications();

  Future<bool> eventHasNotification(Event event);

  Future<bool> courseHasNotifications(Event event);

  Future<void> cancelEventNotification(Event event);

  Future<void> cancelCourseNotifications(Event event);

  Future<void> getPermission();

  Future<bool> allowedNotifications();

  Future<void> removeChannel(String channel);

  Future<void> cancelBookingNotification(int bookingId);

  Future<List<NotificationModel>> getBookingNotifications();

  Future<bool> initialize();
}
