import 'package:tumble/core/ui/data/string_constant_group.dart';

class RuntimeErrorStrings extends StringConstantGroup {
  RuntimeErrorStrings(super.localizedStrings);

  String programFetch() => localizedStrings.runtimeErrorProgramFetch;
  String scheduleFetch() => localizedStrings.runtimeErrorScheduleFetch;
  String timeout() => localizedStrings.runtimeErrorTimeout;
  String emptySchedule() => localizedStrings.runtimeErrorEmptySchedule;
  String login() => localizedStrings.runtimeErrorLogin;
  String loginSuccess() => localizedStrings.runtimeErrorLoginSuccess;
  String unkown() => localizedStrings.runtimeErrorUnknown;
  String authentication() => localizedStrings.runtimeErrorAuthentication;
  String noBookmarks() => localizedStrings.runtimeErrorNoBookmarks;
  String missingLocations() => localizedStrings.runtimeErrorMissingLocations;
  String missingTeachers() => localizedStrings.runtimeErrorMissingTeachers;
  String noCachedSchedule() => localizedStrings.runtimeErrorNoCachedSchedule;
  String failedExamSignup() => localizedStrings.runtimeErrorFailedExamSignup;
  String invalidInputFields() => localizedStrings.runtimeErrorInvalidInputFields;
  String resourceUnavailable() => localizedStrings.runtimeErrorResourceUnavailable;
  String maxResourcesBooked() => localizedStrings.runtimeErrorMaxResourcesBooked;
  String resourceBookCollision() => localizedStrings.runtimeErrorResourceBookCollision;
  String confirmBookingFailed() => localizedStrings.runtimeErrorConfirmBookingFailed;
  String missingTitle() => localizedStrings.runtimeErrorMissingTitle;
}
