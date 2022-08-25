import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tumble/core/ui/data/string_constant_group.dart';

class ScaffoldMessageType extends StringConstantGroup {
  ScaffoldMessageType(AppLocalizations localizedStrings) : super(localizedStrings);

  String createdNotificationForCourse(String courseName, int eventCount) =>
      localizedStrings.scaffoldMessageCreatedNotificationForCourse(eventCount, courseName);

  String createdNotificationForEvent(String eventName) =>
      localizedStrings.scaffoldMessageCreatedNotificationForEvent(eventName);

  String cancelledAllSetNotifications() => localizedStrings.scaffoldMessageCancelledAllSetNotifications;

  String cancelledEventNotification(String event) => Intl.message('Cancelled notification for $event', args: [event]);

  String cancelledCourseNotifications(String course) =>
      Intl.message('Cancelled notifications for $course', args: [course]);

  String cancelNotificationsFailed(String objectName) =>
      Intl.message('Failed to cancel notifications for $objectName', args: [objectName]);

  String openEventOptionsFailed() => 'Schedule must be default to access options';

  String changeTheme(String themeType) => Intl.message('Changed theme to $themeType', args: [themeType]);

  String changedSchool(String schoolName) => Intl.message('Changed school to $schoolName', args: [schoolName]);

  String changedDefaultView(String viewType) => Intl.message('Changed default viewtype to $viewType', args: [viewType]);

  String changedDefaultSchedule(String scheduleId) =>
      Intl.message('Changed default schedule to $scheduleId', args: [scheduleId]);

  String changedDefaultNotificationOffset(int offset) =>
      Intl.message('Changed default notification offset to $offset before start time', args: [offset]);

  String addedBookmark(String scheduleId) => Intl.message('Saved $scheduleId to bookmarks', args: [scheduleId]);

  String removedBookmark(String scheduleId) => Intl.message('Removed $scheduleId from bookmarks', args: [scheduleId]);

  String openExternalUrlFailed(String name) => Intl.message('Could not open $name', args: [name]);

  String updatedCourseColor(String courseName) =>
      Intl.message('Updated course color for $courseName', args: [courseName]);
}
