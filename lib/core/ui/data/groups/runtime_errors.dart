import 'package:flutter/cupertino.dart';
import 'package:tumble/core/ui/data/string_constant_group.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RuntimeErrorStrings extends StringConstantGroup {
  RuntimeErrorStrings(AppLocalizations localizedStrings) : super(localizedStrings);

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
}
