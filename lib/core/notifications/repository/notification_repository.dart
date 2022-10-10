import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:collection/collection.dart';
import 'package:darq/darq.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/notifications/builders/notification_service_builder.dart';
import 'package:tumble/core/api/database/repository/database_repository.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/backend_models/bookmarked_schedule_model.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';
import 'package:tumble/core/notifications/interface/inotification_service.dart';
import 'package:tumble/core/shared/notification_channels.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';

class NotificationRepository implements INotificationService {
  final _notificationServiceBuilder = NotificationServiceBuilder();
  final _databaseService = getIt<DatabaseRepository>();
  final _awesomeNotifications = getIt<AwesomeNotifications>();
  final String _defaultIcon = "resource://drawable/res_tumble_app_logo";

  @override
  void assignAllNotificationsWithNewDuration(Duration newDuration) async {
    List<NotificationModel> currentNotifications = await _awesomeNotifications.listScheduledNotifications();

    final List<String> bookmarkedScheduleIds = getIt<SharedPreferences>()
        .getStringList(PreferenceTypes.bookmarks)!
        .map((json) => bookmarkedScheduleModelFromJson(json).scheduleId)
        .toList();

    List<String?> notificationChannelKeys = currentNotifications
        .map((NotificationModel notificationModel) => notificationModel.content!.id.toString())
        .toList();

    final List<ScheduleModel?> bookmarkedUserSchedules = [];

    if (bookmarkedScheduleIds.isNotEmpty) {
      for (String scheduleId in bookmarkedScheduleIds) {
        bookmarkedUserSchedules.add(await _databaseService.getOneSchedule(scheduleId));
      }

      for (ScheduleModel? bookmarkedSchedule in bookmarkedUserSchedules) {
        if (bookmarkedSchedule != null) {
          if (currentNotifications.isNotEmpty) {
            final List<Event> eventsThatNeedReassign = bookmarkedSchedule.days
                .expand((Day day) => day.events) // Flatten nested list
                .where((Event event) => notificationChannelKeys.contains(event.id.encodeUniqueIdentifier().toString()))
                .toList();
            for (Event event in eventsThatNeedReassign) {
              _notificationServiceBuilder.buildOffsetNotification(
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
    List<String>? bookmarkedScheduleIdStrings = getIt<SharedPreferences>().getStringList(PreferenceTypes.bookmarks);
    bookmarkedScheduleIdStrings ??= <String>[];

    final List<String> bookmarkedScheduleIds =
        bookmarkedScheduleIdStrings.map((e) => bookmarkedScheduleModelFromJson(e).scheduleId).toList();

    return await getIt<AwesomeNotifications>().initialize(_defaultIcon, [
      ...bookmarkedScheduleIds
          .map((scheduleId) => _notificationServiceBuilder.buildNotificationChannel(
              channelKey: scheduleId,
              channelName: 'Channel for $scheduleId',
              channelDescription: 'A notification channel for the schedule under id -> $scheduleId'))
          .toList(),
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
  Future<void> removeChannel(String channel) async => await _awesomeNotifications.removeChannel(channel);

  @override
  Future<void> cancelBookingNotification(int bookingId) async => await _awesomeNotifications.cancel(bookingId);

  @override
  Future<List<NotificationModel>> getBookingNotifications() async =>
      (await _awesomeNotifications.listScheduledNotifications())
          .where((element) => element.content!.channelKey == NotificationChannels.resources)
          .toList();
}
