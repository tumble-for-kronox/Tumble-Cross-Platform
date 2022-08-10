import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/builders/notification_service_builder.dart';
import 'package:tumble/core/api/interface/inotification_service.dart';
import 'package:tumble/core/database/repository/database_repository.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';

class NotificationRepository implements INotificationService {
  final _notificationServiceBuilder = NotificationServiceBuilder();
  final _databaseService = getIt<DatabaseRepository>();
  final _preferenceService = getIt<SharedPreferences>();
  final _awesomeNotifications = getIt<AwesomeNotifications>();

  @override
  void assignWithNewDuration(
      Duration newDuration, ScheduleModel currentScheduleModel) async {
    List<NotificationModel> currentNotifications =
        await _awesomeNotifications.listScheduledNotifications();
    final defaultUserScheduleId =
        _preferenceService.getString(PreferenceTypes.schedule);
    final ScheduleModel? defaultUserSchedule =
        await _databaseService.getOneSchedule(defaultUserScheduleId!);
    if (defaultUserSchedule != null && currentNotifications.isNotEmpty) {
      List<String?> notificationChannelKeys = currentNotifications
          .map((NotificationModel notificationModel) =>
              notificationModel.content!.channelKey)
          .toList();

      final List<Event> eventsThatNeedReassign = defaultUserSchedule.days
          .expand((Day day) => day.events) // Flatten nested list
          .toList()
          .where((Event event) => notificationChannelKeys.contains(event.id))
          .toList();

      for (Event event in eventsThatNeedReassign) {
        _notificationServiceBuilder.buildNotification(
            id: event.id.encodeUniqueIdentifier(),
            channelKey: currentScheduleModel.id,
            groupkey: event.course.id,
            title: event.title,
            body: event.course.englishName,
            date: event.timeStart.subtract(newDuration));
      }
    }
  }

  @override
  void updateDispatcher(
      ScheduleModel newScheduleModel, ScheduleModel oldScheduleModel) async {
    final int notificationTime =
        _preferenceService.getInt(PreferenceTypes.notificationTime)!;

    final Duration defaultUserDuration = Duration(minutes: notificationTime);

    List<NotificationModel> currentNotifications =
        await _awesomeNotifications.listScheduledNotifications();
    Set<Event> newEvents =
        newScheduleModel.days.expand((Day day) => day.events).toSet();
    Set<Event> oldEvents =
        oldScheduleModel.days.expand((Day day) => day.events).toSet();

    /// Get all differing events by performing set subtraction on
    /// [oldEvents] and [newEvents], then filter to only get the
    /// events that have notifications created for them
    List<Event> eventsThatNeedReassign = newEvents
        .difference(oldEvents)
        .where((Event event) => currentNotifications
            .map(
              (NotificationModel notificationModel) =>
                  notificationModel.content!.channelKey,
            )
            .contains(event.id))
        .toList();

    for (Event event in eventsThatNeedReassign) {
      _notificationServiceBuilder.buildNotification(
          id: event.id.encodeUniqueIdentifier(),
          channelKey: newScheduleModel.id,
          groupkey: event.course.id,
          title: event.title,
          body: event.course.englishName,
          date: event.timeStart.subtract(defaultUserDuration));
    }
  }
}
