import 'package:tumble/core/ui/data/string_constant_group.dart';

class UserEventStrings extends StringConstantGroup {
  UserEventStrings(super.localizedStrings);

  String needToSignup() => localizedStrings.userEventsNeedToSignupTitle;
  String alreadySignedUp() => localizedStrings.userEventsAlreadySignedUpTitle;
  String upcoming() => localizedStrings.userEventsUpcomingTitle;
  String registerButton() => localizedStrings.userEventsRegisterButton;
  String openKronoxButton() => localizedStrings.userEventsOpenKronoxButton;
  String failedToLoad() => localizedStrings.userEventsFailedToLoadExams;
  String empty() => localizedStrings.userEventsEmpty;
  String unregisterButton() => localizedStrings.userEventsUnregisterButton;
  String unregisterUntil() => localizedStrings.userEventsUnregisterUntil;
  String registerBefore() => localizedStrings.userEventsRegisterBefore;
  String availableEvents() => localizedStrings.userEventsAvailableEvents;
}
