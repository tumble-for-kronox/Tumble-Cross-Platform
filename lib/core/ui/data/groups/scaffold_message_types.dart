import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tumble/core/ui/data/string_constant_group.dart';

class ScaffoldMessageType extends StringConstantGroup {
  ScaffoldMessageType(AppLocalizations localizedStrings) : super(localizedStrings);

  String createdNotificationForCourse(String courseName, int eventCount) =>
      localizedStrings.scaffoldMessageCreatedNotificationForCourse(eventCount, courseName);
  String createdNotificationForEvent(String eventName) =>
      localizedStrings.scaffoldMessageCreatedNotificationForEvent(eventName);
  String cancelledAllSetNotifications() => localizedStrings.scaffoldMessageCancelledAllSetNotifications;
  String cancelledEventNotification(String event) => localizedStrings.scaffoldMessageCancelledEventNotification(event);
  String cancelledCourseNotifications(String course) =>
      localizedStrings.scaffoldMessageCancelledCourseNotifications(course);
  String cancelNotificationsFailed(String objectName) =>
      localizedStrings.scaffoldMessageCancelNotificationsFailed(objectName);
  String openEventOptionsFailed() => localizedStrings.scaffoldMessageOpenEventOptionsFailed;
  String changeTheme(String themeType) => localizedStrings.scaffoldMessageChangeTheme(themeType);
  String changedSchool(String schoolName) => localizedStrings.scaffoldMessageChangedSchool(schoolName);
  String changedDefaultView(String viewType) => localizedStrings.scaffoldMessageChangedDefaultView(viewType);
  String changedDefaultSchedule(String scheduleId) =>
      localizedStrings.scaffoldMessageChangedDefaultSchedule(scheduleId);
  String changedDefaultNotificationOffset(int offset) => changedDefaultNotificationOffset(offset);
  String addedBookmark(String scheduleId) => localizedStrings.scaffoldMessageAddedBookmark(scheduleId);
  String removedBookmark(String scheduleId) => localizedStrings.scaffoldMessageRemovedBookmark(scheduleId);
  String openExternalUrlFailed(String name) => localizedStrings.scaffoldMessageOpenExternalUrlFailed(name);
  String updatedCourseColor(String courseName) => localizedStrings.scaffoldMessageUpdatedCourseColor(courseName);
  String bookedResource() => localizedStrings.scaffoldMessageBookedResource;
  String unbookedResource() => localizedStrings.scaffoldMessageUnbookedResource;
  String confirmedBooking() => localizedStrings.scaffoldMessageConfirmedBooking;
  String autoSignupCompleted(int numberOfSignedUpEvents) =>
      localizedStrings.scaffoldMessageAutoSignupCompleted(numberOfSignedUpEvents);
  String autoSignupFailed(int numberOfFailedSignUpEvents) =>
      localizedStrings.scaffoldMessageAutoSignupFailed(numberOfFailedSignUpEvents);
  String autoSignupCompleteAndFail(int numberOfSignedUpEvents, int numberOfFailedSignUpEvents) =>
      localizedStrings.scaffoldMessageAutoSignupCompletedAndFailed(numberOfFailedSignUpEvents, numberOfSignedUpEvents);
}
