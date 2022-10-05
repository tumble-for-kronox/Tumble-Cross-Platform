import 'package:flutter/foundation.dart';
import 'package:tumble/core/api/apiservices/api_booking_response.dart';
import 'package:tumble/core/api/apiservices/api_user_response.dart';
import 'package:tumble/core/models/api_models/resource_model.dart';

@immutable
abstract class IUserService {
  Future<ApiUserResponse> getUserEvents(String sessionToken);

  Future<ApiUserResponse> postUserLogin(String username, String password, String school);

  Future<ApiUserResponse> getRefreshSession(String refreshToken);

  Future<ApiUserResponse> putRegisterAllAvailableUserEvents(String sessionToken);

  Future<ApiUserResponse> putRegisterUserEvent(String eventId, String sessionToken);

  Future<ApiUserResponse> putUnregisterUserEvent(String eventId, String sessionToken);

  Future<ApiBookingResponse> getSchoolResources(String sessionToken);

  Future<ApiBookingResponse> getResourceAvailabilities(String resourceId, DateTime date, String sessionToken);

  Future<ApiBookingResponse> getUserBookings(String sessionToken);

  Future<ApiBookingResponse> putBookResources(
      String resourceId, DateTime date, AvailabilityValue bookingSlot, String sessionToken);

  Future<ApiBookingResponse> putUnbookResources(String bookingId, String sessionToken);

  Future<ApiBookingResponse> putConfirmBooking(String sessionToken, String resourceId, String bookingId);
}
