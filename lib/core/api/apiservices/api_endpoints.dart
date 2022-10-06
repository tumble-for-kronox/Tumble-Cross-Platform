import 'dart:io';

import 'package:flutter/foundation.dart';

///
/// Stores all endpoints used for interacting with the .NET backend,
/// as well as the query parameters for different endpoints.
///
@immutable
class ApiEndPoints {
  // Endpoints
  static String debugBaseUrl = Platform.isAndroid ? '10.0.2.2:7036' : 'localhost:7036';
  static const String baseUrl = 'tumble.hkr.se:443';
  static const String getSchedules = '/schedules/search';
  static const String getOneSchedule = '/schedules/';
  static const String getUserEvents = 'users/events';
  static const String getRefreshSession = 'users/refresh';
  static const String getSchoolResources = 'resources';
  static const String getResourceAvailability = 'resources/';
  static const String getUserBookings = 'resources/userbookings';
  static const String putRegisterAll = 'users/events/register/all';
  static const String putRegisterEvent = 'users/events/register/';
  static const String putUnregisterEvent = 'users/events/unregister/';
  static const String putBookResource = 'resources/book';
  static const String putUnbookResource = 'resources/unbook';
  static const String putConfirmBooking = 'resources/confirm';
  static const String postSubmitIssue = '/misc/submitIssue';
  static const String postUserLogin = 'users/login';

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
