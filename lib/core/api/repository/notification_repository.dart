import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:darq/darq.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/builders/notification_service_builder.dart';
import 'package:tumble/core/api/interface/inotification_service.dart';
import 'package:tumble/core/database/repository/database_repository.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/api_models/bookmarked_schedule_model.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';

class NotificationRepository implements INotificationService {
  final _notificationServiceBuilder = NotificationServiceBuilder();
  final _databaseService = getIt<DatabaseRepository>();
  final _awesomeNotifications = getIt<AwesomeNotifications>();
  final String _defaultIcon = "resource://drawable/res_tumble_app_logo";

  @override
  void assignAllNotificationsWithNewDuration(Duration newDuration) async {
    List<NotificationModel> currentNotifications =
        await _awesomeNotifications.listScheduledNotifications();

    final List<String> bookmarkedScheduleIds = getIt<SharedPreferences>()
        .getStringList(PreferenceTypes.bookmarks)!
        .map((json) => bookmarkedScheduleModelFromJson(json).scheduleId)
        .toList();

    List<String?> notificationChannelKeys = currentNotifications
        .map((NotificationModel notificationModel) =>
            notificationModel.content!.id.toString())
        .toList();

    final List<ScheduleModel?> bookmarkedUserSchedules = [];

    if (bookmarkedScheduleIds.isNotEmpty) {
      for (String scheduleId in bookmarkedScheduleIds) {
        bookmarkedUserSchedules
            .add(await _databaseService.getOneSchedule(scheduleId));
      }

      for (ScheduleModel? bookmarkedSchedule in bookmarkedUserSchedules) {
        if (bookmarkedSchedule != null) {
          if (currentNotifications.isNotEmpty) {
            final List<Event> eventsThatNeedReassign = bookmarkedSchedule.days
                .expand((Day day) => day.events) // Flatten nested list
                .where((Event event) => notificationChannelKeys
                    .contains(event.id.encodeUniqueIdentifier().toString()))
                .toList();
            for (Event event in eventsThatNeedReassign) {
              _notificationServiceBuilder.buildNotification(
                  id: event.id.encodeUniqueIdentifier(),
                  channelKey: bookmarkedSchedule.id,
                  groupkey: event.course.id,
                  title: event.title.capitalize(),
                  body: event.course.englishName,
                  date: event.from);
            }
          }
        }
      }
    }
  }

  @override
  void updateDispatcher(
      ScheduleModel newScheduleModel, ScheduleModel oldScheduleModel) async {
    final List<NotificationModel> currentNotifications =
        await _awesomeNotifications.listScheduledNotifications();

    final List<String?> notificationChannelKeys = currentNotifications
        .map((NotificationModel notificationModel) =>
            notificationModel.content!.id.toString())
        .toList();

    final Set<Event> newEvents = newScheduleModel.days
        .expand((Day day) => day.events)
        .distinct((e) => e.id)
        .toSet();
    final Set<Event> oldEvents = oldScheduleModel.days
        .expand((Day day) => day.events)
        .distinct((e) => e.id)
        .toSet();

    /// Get all differing events by performing set subtraction on
    /// [oldEvents] and [newEvents], then filter to only get the
    /// events that have notifications created for them
    List<Event> eventsThatNeedReassign = newEvents
        .difference(oldEvents)
        .where((Event event) => notificationChannelKeys
            .contains(event.id.encodeUniqueIdentifier().toString()))
        .toList();

    log(eventsThatNeedReassign.toString());

    for (Event event in eventsThatNeedReassign) {
      _notificationServiceBuilder.buildNotification(
          id: event.id.encodeUniqueIdentifier(),
          channelKey: newScheduleModel.id,
          groupkey: event.course.id,
          title: event.title.capitalize(),
          body: event.course.englishName,
          date: event.from);
    }
  }

  @override
  void cancelAllNotifications() {
    _awesomeNotifications.cancelAll();
  }

  @override
  Future<bool> initialize() async {
    if (getIt<SharedPreferences>().getStringList(PreferenceTypes.bookmarks) !=
        null) {
      final List<String> bookmarkedScheduleIds = getIt<SharedPreferences>()
          .getStringList(PreferenceTypes.bookmarks)!
          .map((e) => bookmarkedScheduleModelFromJson(e).scheduleId)
          .toList();

      return await getIt<AwesomeNotifications>().initialize(
          _defaultIcon,
          bookmarkedScheduleIds
              .map((scheduleId) =>
                  _notificationServiceBuilder.buildNotificationChannel(
                      channelKey: scheduleId,
                      channelName: 'Channel for $scheduleId',
                      channelDescription:
                          'A notification channel for the schedule under id -> $scheduleId'))
              .toList());
    }
    return false;
  }
}
