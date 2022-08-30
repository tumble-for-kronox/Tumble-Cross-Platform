import 'package:flutter/foundation.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';

@immutable
abstract class INotificationService {
  void updateDispatcher(
      ScheduleModel newScheduleModel, ScheduleModel oldScheduleModel);

  void assignAllNotificationsWithNewDuration(Duration newDuration);

  void cancelAllNotifications();

  Future<bool> initialize();
}
