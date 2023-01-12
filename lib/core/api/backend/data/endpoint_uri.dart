import 'package:tumble/core/api/backend/data/endpoints.dart';
import 'package:tumble/core/ui/app_switch/data/school_enum.dart';

class EndpointUri {
  static Uri getSchedule(String scheduleId, int schoolIndex) => Uri.https(
      Endpoints.baseUrl,
      '${Endpoints.getOneSchedule}$scheduleId',
      {Endpoints.school: schoolIndex.toString()});

  static Uri getProgram(
          String searchQuery, String defaultSchool, int schoolIndex) =>
      Uri.https(Endpoints.baseUrl, Endpoints.getSchedules, {
        Endpoints.search: searchQuery,
        Endpoints.school: schoolIndex.toString()
      });

  static Uri getUserEvents(SchoolEnum schoolId) => Uri.https(
        Endpoints.baseUrl,
        Endpoints.getUserEvents,
        {Endpoints.school: schoolId.toString()},
      );

  static Uri getSchoolResources(int schoolIndex) => Uri.https(Endpoints.baseUrl,
      Endpoints.getSchoolResources, {Endpoints.school: schoolIndex.toString()});

  static Uri getResourceAvailabilities(
          String resourceId, int schoolIndex, DateTime date) =>
      Uri.https(
          Endpoints.baseUrl, Endpoints.getResourceAvailability + resourceId, {
        Endpoints.school: schoolIndex.toString(),
        Endpoints.date: date.toIso8601String()
      });

  static Uri getUserBookings(int schoolIndex) => Uri.https(Endpoints.baseUrl,
      Endpoints.getUserBookings, {Endpoints.school: schoolIndex.toString()});

  static Uri putRegisterUserEvent(String eventId, int schoolIndex) =>
      Uri.https(Endpoints.baseUrl, Endpoints.putRegisterEvent + eventId, {
        Endpoints.school: schoolIndex.toString(),
      });

  static Uri putUnregisterUserEvent(String eventId, int schoolIndex) =>
      Uri.https(Endpoints.baseUrl, Endpoints.getSchedules + eventId, {
        Endpoints.school: schoolIndex.toString(),
      });

  static Uri putRegisterAll(int schoolIndex) =>
      Uri.https(Endpoints.baseUrl, Endpoints.putRegisterAll, {
        Endpoints.school: schoolIndex.toString(),
      });

  static Uri putBookResource(int schoolIndex) =>
      Uri.https(Endpoints.baseUrl, Endpoints.putBookResource, {
        Endpoints.school: schoolIndex.toString(),
      });

  static Uri putUnbookResource(int schoolIndex, String bookingId) =>
      Uri.https(Endpoints.baseUrl, Endpoints.putUnbookResource, {
        Endpoints.school: schoolIndex.toString(),
        Endpoints.bookingId: bookingId
      });

  static Uri putConfirmBooking(int schoolIndex) =>
      Uri.https(Endpoints.baseUrl, Endpoints.putConfirmBooking, {
        Endpoints.school: schoolIndex.toString(),
      });

  static Uri postUserLogin(int schoolIndex) => Uri.https(Endpoints.baseUrl,
      Endpoints.postUserLogin, {Endpoints.school: schoolIndex.toString()});

  static Uri postSubmitIssue() => Uri.https(
        Endpoints.baseUrl,
        Endpoints.postSubmitIssue,
      );

  static Uri getUser() => Uri.https(Endpoints.baseUrl, Endpoints.user);
}
