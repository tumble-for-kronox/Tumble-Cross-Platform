import 'package:tumble/core/ui/data/string_constant_group.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PopUpStrings extends StringConstantGroup {
  PopUpStrings(AppLocalizations localizedStrings) : super(localizedStrings);

  String notificationRequestTitle() => localizedStrings.popUpNotificationPermissionTitle;
  String notificationRequestDescription() => localizedStrings.popUpNotificationPermissionDescription;
  String autoSignupTitle() => localizedStrings.popUpExamAutoSignupTitle;
  String autoSignupBody() => localizedStrings.popUpExamAutoSignupBody;
  String scheduleHelpFirstLine() => localizedStrings.popUpScheduleHelpFirstLine;
  String scheduleHelpSecondLine() => localizedStrings.popUpScheduleHelpSecondLine;
  String scheduleIsEmptyTitle() => localizedStrings.popUpScheduleIsEmptyTitle;
  String scheduleIsEmptyBody() => localizedStrings.popUpScheduleIsEmptyBody;
  String scheduleFetchError() => localizedStrings.popUpScheduleFetchError;
  String resourceFetchErrorTitle() => localizedStrings.popUpResourceFetchErrorTitle;
  String resourceFetchErrorBody() => localizedStrings.popUpResourceFetchErrorBody;
}
