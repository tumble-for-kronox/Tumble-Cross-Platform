import 'package:flutter/foundation.dart';
import 'package:tumble/core/api/backend/response_types/api_response.dart';
import 'package:tumble/core/models/backend_models/kronox_user_model.dart';
import 'package:tumble/core/models/backend_models/resource_model.dart';

@immutable
abstract class IUserActionService {
  Future<ApiResponse> userEvents(KronoxUserModel session);

  Future<ApiResponse> userLogin(
      String username, String password, String school);

  Future<ApiResponse> registerAllAvailableUserEvents(KronoxUserModel session);

  Future<ApiResponse> registerUserEvent(
      String eventId, KronoxUserModel session);

  Future<ApiResponse> unregisterUserEvent(
      String eventId, KronoxUserModel session);

  Future<ApiResponse> schoolResources(KronoxUserModel session);

  Future<ApiResponse> resourceAvailabilities(
      String resourceId, DateTime date, KronoxUserModel session);

  Future<ApiResponse> userBookings(KronoxUserModel session);

  Future<ApiResponse> bookResources(String resourceId, DateTime date,
      AvailabilityValue bookingSlot, KronoxUserModel session);

  Future<ApiResponse> unbookResources(
      String bookingId, KronoxUserModel session);

  Future<ApiResponse> confirmBooking(
      String resourceId, String bookingId, KronoxUserModel session);
}
