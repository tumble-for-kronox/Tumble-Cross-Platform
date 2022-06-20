import 'package:flutter/foundation.dart';

@immutable
abstract class INotificationService {

  Future<void> createScheduleReminderNotification();

}