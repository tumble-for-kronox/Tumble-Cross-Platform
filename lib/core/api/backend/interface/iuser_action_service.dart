import 'package:flutter/foundation.dart';
import 'package:tumble/core/api/backend/response_types/booking_response.dart';
import 'package:tumble/core/api/backend/response_types/user_response.dart';
import 'package:tumble/core/models/backend_models/resource_model.dart';

@immutable
abstract class IUserActionService {
  Future<UserResponse> userEvents(String sessionToken);

  Future<UserResponse> userLogin(String username, String password, String school);

  Future<UserResponse> refreshSession(String refreshToken);

  Future<UserResponse> registerAllAvailableUserEvents(String sessionToken);

  Future<UserResponse> registerUserEvent(String eventId, String sessionToken);

  Future<UserResponse> unregisterUserEvent(String eventId, String sessionToken);

  Future<BookingResponse> schoolResources(String sessionToken);

  Future<BookingResponse> resourceAvailabilities(String resourceId, DateTime date, String sessionToken);

  Future<BookingResponse> userBookings(String sessionToken);

  Future<BookingResponse> bookResources(
      String resourceId, DateTime date, AvailabilityValue bookingSlot, String sessionToken);

  Future<BookingResponse> unbookResources(String bookingId, String sessionToken);

  Future<BookingResponse> confirmBooking(String sessionToken, String resourceId, String bookingId);
}
