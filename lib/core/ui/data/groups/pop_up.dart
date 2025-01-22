import 'package:tumble/core/ui/data/string_constant_group.dart';

class PopUpStrings extends StringConstantGroup {
  PopUpStrings(super.localizedStrings);

  String notificationRequestTitle() => localizedStrings.popUpNotificationPermissionTitle;
  String missingProgramRequestDescription() => localizedStrings.popUpProgramFetchErrorDescription;
  String notificationRequestDescription() => localizedStrings.popUpNotificationPermissionDescription;
  String scheduleHelpFirstLine() => localizedStrings.popUpScheduleHelpFirstLine;
  String scheduleHelpSecondLine() => localizedStrings.popUpScheduleHelpSecondLine;
  String scheduleIsEmptyTitle() => localizedStrings.popUpScheduleIsEmptyTitle;
  String scheduleIsEmptyBody() => localizedStrings.popUpScheduleIsEmptyBody;
  String scheduleFetchError() => localizedStrings.popUpScheduleFetchError;
  String resourceFetchErrorTitle() => localizedStrings.popUpResourceFetchErrorTitle;
  String resourceFetchErrorBody() => localizedStrings.popUpResourceFetchErrorBody;
  String timeOutDecsription() => localizedStrings.popUpTimeoutErrorDescription;
}
