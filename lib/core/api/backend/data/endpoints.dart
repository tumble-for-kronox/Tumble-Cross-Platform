import 'dart:io';

import 'package:flutter/foundation.dart';

///
/// Stores all endpoints used for interacting with the .NET backend,
/// as well as the query parameters for different endpoints.
///
@immutable
class Endpoints {
  // Endpoints
  static String debugBaseUrl = Platform.isAndroid ? '10.0.2.2:7036' : '192.168.1.178:80';
  static String baseUrl = kDebugMode ? debugBaseUrl : 'tumble.hkr.se';
  static const String pathPrefix = '/api';

  static const String getSchedules = '$pathPrefix/schedules/search';
  static const String getOneSchedule = '$pathPrefix/schedules/';
  static const String getUserEvents = '$pathPrefix/users/events';
  static const String getRefreshSession = '$pathPrefix/users';
  static const String getSchoolResources = '$pathPrefix/resources';
  static const String getResourceAvailability = '$pathPrefix/resources/';
  static const String getUserBookings = '$pathPrefix/resources/userbookings';
  static const String putRegisterAll = '$pathPrefix/users/events/register/all';
  static const String putRegisterEvent = '$pathPrefix/users/events/register/';
  static const String putUnregisterEvent = '$pathPrefix/users/events/unregister/';
  static const String putBookResource = '$pathPrefix/resources/book';
  static const String putUnbookResource = '$pathPrefix/resources/unbook';
  static const String putConfirmBooking = '$pathPrefix/resources/confirm';
  static const String postSubmitIssue = '$pathPrefix/misc/submitIssue';
  static const String postUserLogin = '$pathPrefix/users/login';

  // Path parameters
  static const String eventId = 'eventId';

  // Schedule query parameters
  static const String school = 'schoolId';
  static const String startTag = 'startTag';
  static const String search = 'searchQuery';
  static const String sessionToken = 'sessionToken';
  static const String resourceId = 'resourceId';
  static const String bookingId = 'bookingId';

  // Login parameters
  static const String password = 'password';
  static const String username = 'username';
  static const String date = 'date';
  static const String bookingSlot = 'slot';

  // Issue parameters
  static const String issueSubject = 'title';
  static const String issueBody = 'description';
}
