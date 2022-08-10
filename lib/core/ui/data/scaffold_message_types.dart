import 'package:intl/intl.dart';

class ScaffoldMessageType {
  static String createdNotificationForCourse(String course) =>
      Intl.message('Sucessfully created notification for $course',
          args: [course]);

  static String createdNotificationForEvent(String event) =>
      Intl.message('Sucessfully created notification for $event',
          args: [event]);

  static String changeTheme(String themeType) =>
      Intl.message('Changed theme to $themeType', args: [themeType]);

  static String changedSchool(String schoolName) =>
      Intl.message('Changed school to $schoolName', args: [schoolName]);

  static String changedDefaultView(String viewType) =>
      Intl.message('Changed default viewtype to $viewType', args: [viewType]);

  static String changedDefaultSchedule(String scheduleId) =>
      Intl.message('Changed default schedule to $scheduleId',
          args: [scheduleId]);

  static String changedDefaultNotificationOffset(int offset) => Intl.message(
      'Changed default notification offset to $offset before start time',
      args: [offset]);

  static String cancelledSetNotificationsForCourse(String course) =>
      Intl.message('Cancelled notifications for events in $course',
          args: [course]);

  static String cancelledSetNotificationsForEvent(String event) =>
      Intl.message('Cancelled notification for $event', args: [event]);

  static String addedBookmark(String scheduleId) =>
      Intl.message('Saved $scheduleId to bookmarks', args: [scheduleId]);

  static String removedBookmark(String scheduleId) =>
      Intl.message('Removed $scheduleId from bookmarks', args: [scheduleId]);
}
