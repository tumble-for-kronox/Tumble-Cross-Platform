import 'package:tumble/core/ui/data/string_constants.dart';

class RuntimeErrorType {
  static String programFetchError() => S.runtimeError.programFetch();
  static String scheduleFetchError() => S.runtimeError.scheduleFetch();
  static String timeoutError() => S.runtimeError.timeout();
  static String emptyScheduleError() => S.runtimeError.emptySchedule();
  static String loginError() => S.runtimeError.login();
  static String unknownError() => S.runtimeError.unkown();
  static String authenticationError() => S.runtimeError.authentication();
  static String loginSuccess() => S.runtimeError.loginSuccess();
  static String noBookmarks() => S.runtimeError.noBookmarks();
  static String missingLocations() => S.runtimeError.missingLocations();
  static String missingTeachers() => S.runtimeError.missingTeachers();
  static String noCachedSchedule() => S.runtimeError.noCachedSchedule();
  static String failedExamSignUp() => S.runtimeError.failedExamSignup();
  static String invalidInputFields() => S.runtimeError.invalidInputFields();
  static String resourceUnavailable() => S.runtimeError.resourceUnavailable();
  static String maxResourcesBooked() => S.runtimeError.maxResourcesBooked();
  static String resourceBookCollision() =>
      S.runtimeError.resourceBookCollision();
  static String confirmBookingFailed() => S.runtimeError.confirmBookingFailed();
}
