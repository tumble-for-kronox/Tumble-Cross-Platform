import 'package:flutter/foundation.dart';
import 'package:tumble/core/api/backend/response_types/booking_response.dart';
import 'package:tumble/core/api/backend/response_types/user_response.dart';
import 'package:tumble/core/models/backend_models/kronox_user_model.dart';
import 'package:tumble/core/models/backend_models/resource_model.dart';

import '../response_types/refresh_response.dart';

@immutable
abstract class IUserActionService {
  Future<RefreshResponse<UserResponse>> userEvents(KronoxUserModel session);

  Future<UserResponse> userLogin(String username, String password, String school);

  Future<UserResponse> refreshSession(String refreshToken);

  Future<RefreshResponse> registerAllAvailableUserEvents(KronoxUserModel session);

  Future<RefreshResponse> registerUserEvent(String eventId, KronoxUserModel session);

  Future<RefreshResponse> unregisterUserEvent(String eventId, KronoxUserModel session);

  Future<RefreshResponse> schoolResources(KronoxUserModel session);

  Future<RefreshResponse> resourceAvailabilities(String resourceId, DateTime date, KronoxUserModel session);

  Future<RefreshResponse> userBookings(KronoxUserModel session);

  Future<RefreshResponse> bookResources(
      String resourceId, DateTime date, AvailabilityValue bookingSlot, KronoxUserModel session);

  Future<RefreshResponse> unbookResources(String bookingId, KronoxUserModel session);

  Future<RefreshResponse> confirmBooking(String resourceId, String bookingId, KronoxUserModel session);
}
