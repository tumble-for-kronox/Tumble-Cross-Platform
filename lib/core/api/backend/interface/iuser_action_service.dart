import 'package:flutter/foundation.dart';
import 'package:tumble/core/api/backend/response_types/booking_response.dart';
import 'package:tumble/core/api/backend/response_types/user_response.dart';
import 'package:tumble/core/models/backend_models/resource_model.dart';


@immutable
abstract class IUserActionService {
  Future<UserResponse> userEvents();

  Future<UserResponse> userLogin(String username, String password, String school);

  Future<UserResponse> refreshSession();

  Future<UserResponse> registerAllAvailableUserEvents();

  Future<UserResponse> registerUserEvent(String eventId);

  Future<UserResponse> unregisterUserEvent(String eventId);

  Future<BookingResponse> schoolResources();

  Future<BookingResponse> resourceAvailabilities(String resourceId, DateTime date);

  Future<BookingResponse> userBookings();

  Future<BookingResponse> bookResources(String resourceId, DateTime date, AvailabilityValue bookingSlot);

  Future<BookingResponse> unbookResources(String bookingId);

  Future<BookingResponse> confirmBooking(String resourceId, String bookingId);
}
