import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:collection/collection.dart';
import 'package:darq/darq.dart';
import 'package:tumble/core/api/preferences/repository/preference_repository.dart';
import 'package:tumble/core/api/notifications/builders/notification_service_builder.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';
import 'package:tumble/core/api/notifications/interface/inotification_service.dart';
import 'package:tumble/core/api/notifications/data/notification_channels.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';

class NotificationRepository implements INotificationService {
  final _notificationServiceBuilder = NotificationServiceBuilder();
  final _awesomeNotifications = getIt<AwesomeNotifications>();
  final _preferenceService = getIt<PreferenceRepository>();
  final String _defaultIcon = "resource://drawable/res_tumble_app_logo";

  @override
  Future<void> assignAllNotificationsWithNewDuration(Duration oldOffset, Duration newOffset) async {
    final List<String>? bookmarkedScheduleIds = _preferenceService.bookmarkIds;
    if (bookmarkedScheduleIds == null) return;

    List<NotificationModel> currentNotifications =
        await _awesomeNotifications.getAllNotificationsFromChannels(bookmarkedScheduleIds);

    for (NotificationModel notification in currentNotifications) {
      Map<String, dynamic> notificationSchedule = notification.schedule!.toMap();

      DateTime newNotificationDateTime = DateTime(
        notificationSchedule['year'],
        notificationSchedule['month'],
        notificationSchedule['day'],
        notificationSchedule['hour'],
        notificationSchedule['minute'],
        notificationSchedule['second'],
      ).add(oldOffset).subtract(newOffset).toUtc();

      await _notificationServiceBuilder.buildExactNotification(
        id: notification.content!.id!,
        channelKey: notification.content!.channelKey!,
        groupkey: notification.content!.groupKey!,
        title: notification.content!.title!,
        body: notification.content!.body!,
        date: newNotificationDateTime,
      );
    }

    // THIS IS ALL DEBUGGING LOGS FOR TESTING THE CHANGE IN NOTIFICATION TIMES!!
    List<NotificationModel> newNotifications =
        await _awesomeNotifications.getAllNotificationsFromChannels(bookmarkedScheduleIds);

    for (NotificationModel newNotification in newNotifications) {
      log('POST TEST =============================================');

      log('${newNotification.content!.id!} ===========');

      Map<String, dynamic> newNotificationSchedule = newNotification.schedule!.toMap();

      NotificationModel oldNotification =
          currentNotifications.firstWhere((notification) => notification.content!.id! == newNotification.content!.id!);
      Map<String, dynamic> oldNotificationSchedule = oldNotification.schedule!.toMap();

      DateTime newNotificationDateTime = DateTime(
        newNotificationSchedule['year'],
        newNotificationSchedule['month'],
        newNotificationSchedule['day'],
        newNotificationSchedule['hour'],
        newNotificationSchedule['minute'],
        newNotificationSchedule['second'],
      );

      DateTime oldNotificationDateTime = DateTime(
        oldNotificationSchedule['year'],
        oldNotificationSchedule['month'],
        oldNotificationSchedule['day'],
        oldNotificationSchedule['hour'],
        oldNotificationSchedule['minute'],
        oldNotificationSchedule['second'],
      );

      log('Old Notification time: $oldNotificationDateTime');
      log('New Notification time: $newNotificationDateTime');
      log('Difference: ${oldNotificationDateTime.difference(newNotificationDateTime).toString()}\n');
    }
  }

  @override
  void updateDispatcher(ScheduleModel newScheduleModel, ScheduleModel oldScheduleModel) async {
    final List<NotificationModel> currentNotifications = await _awesomeNotifications.listScheduledNotifications();

    final List<String?> notificationChannelKeys = currentNotifications
        .map((NotificationModel notificationModel) => notificationModel.content!.id.toString())
        .toList();

    final Set<Event> newEvents = newScheduleModel.days.expand((Day day) => day.events).distinct((e) => e.id).toSet();
    final Set<Event> oldEvents = oldScheduleModel.days.expand((Day day) => day.events).distinct((e) => e.id).toSet();

    /// Get all differing events by performing set subtraction on
    /// [oldEvents] and [newEvents], then filter to only get the
    /// events that have notifications created for them
    List<Event> eventsThatNeedReassign = newEvents
        .difference(oldEvents)
        .where((Event event) => notificationChannelKeys.contains(event.id.encodeUniqueIdentifier().toString()))
        .toList();

    for (Event event in eventsThatNeedReassign) {
      _notificationServiceBuilder.buildOffsetNotification(
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
    List<String>? bookmarkedScheduleIds = _preferenceService.bookmarkIds;
    bookmarkedScheduleIds ??= <String>[];
    return await getIt<AwesomeNotifications>().initialize(_defaultIcon, [
      ...bookmarkedScheduleIds
          .map((scheduleId) => _notificationServiceBuilder.buildNotificationChannel(
              channelKey: scheduleId,
              channelName: 'Channel for $scheduleId',
              channelDescription: 'A notification channel for the schedule under id -> $scheduleId'))
          ,
      _notificationServiceBuilder.buildNotificationChannel(
        channelKey: NotificationChannels.resources,
        channelName: "Resources",
        channelDescription: "A notification channel for the school resources and user bookings systems",
      ),
    ]);
  }

  @override
  Future<bool> eventHasNotification(Event event) async =>
      (((await _awesomeNotifications.listScheduledNotifications()).singleWhereOrNull(
            (notificationModel) => notificationModel.content!.id == event.id.encodeUniqueIdentifier(),
          )) !=
          null);

  @override
  Future<bool> courseHasNotifications(Event event) async =>
      (((await _awesomeNotifications.listScheduledNotifications()).firstWhereOrNull(
            (notificationModel) => notificationModel.content!.groupKey == event.course.id,
          )) !=
          null);

  @override
  Future<void> cancelEventNotification(Event event) async =>
      await _awesomeNotifications.cancelSchedule(event.id.encodeUniqueIdentifier());

  @override
  Future<void> cancelCourseNotifications(Event event) async =>
      await _awesomeNotifications.cancelSchedulesByGroupKey(event.course.id);

  @override
  Future<void> getPermission() async => await _awesomeNotifications.requestPermissionToSendNotifications();

  @override
  Future<bool> allowedNotifications() async => _awesomeNotifications.isNotificationAllowed();

  @override
  Future<void> removeChannel(String channel) async => await _awesomeNotifications
      .removeChannel(channel)
      .then((value) => _awesomeNotifications.cancelNotificationsByChannelKey(channel));

  @override
  Future<void> cancelBookingNotification(int bookingId) async => await _awesomeNotifications.cancel(bookingId);

  @override
  Future<List<NotificationModel>> getBookingNotifications() async =>
      (await _awesomeNotifications.listScheduledNotifications())
          .where((element) => element.content!.channelKey == NotificationChannels.resources)
          .toList();
}
