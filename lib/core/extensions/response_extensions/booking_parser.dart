import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:tumble/core/api/backend/response_types/api_response.dart';
import 'package:tumble/core/api/backend/response_types/runtime_error_types.dart';
import 'package:tumble/core/models/backend_models/resource_model.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

extension BookingResponseParsing on Response {
  ApiResponse parseSchoolResources() {
    if (statusCode == 200) {
      List<ResourceModel> schoolResources = List<ResourceModel>.from(
          data.map((e) => resourceModelFromJson(jsonEncode(e))));
      return ApiResponse.success(schoolResources);
    } else if (statusCode == 401) {
      return ApiResponse.unauthorized(RuntimeErrorType.authenticationError());
    } else if (statusCode == 404) {
      return ApiResponse.notFound(RuntimeErrorType.resourceUnavailable());
    }

    return ApiResponse.error(RuntimeErrorType.unknownError(), "Unknown error");
  }

  ApiResponse parseSchoolResource() {
    if (statusCode == 200) {
      return ApiResponse.success(resourceModelFromJson(jsonEncode(data)));
    } else if (statusCode == 401) {
      return ApiResponse.unauthorized(RuntimeErrorType.authenticationError());
    } else if (statusCode == 404) {
      return ApiResponse.notFound(RuntimeErrorType.resourceUnavailable());
    }

    return ApiResponse.error(RuntimeErrorType.unknownError(), "Unknown error");
  }

  Future<ApiResponse> parseUserBookings() async {
    if (statusCode == 200) {
      List<dynamic> jsonList = json.decode(jsonEncode(data));
      List<Booking> userBookings =
          List<Booking>.from(jsonList.map((x) => Booking.fromJson(x)));
      return ApiResponse.success(userBookings);
    } else if (statusCode == 401) {
      return ApiResponse.unauthorized(RuntimeErrorType.authenticationError());
    }

    return ApiResponse.error(RuntimeErrorType.unknownError(), "Unknown error");
  }

  ApiResponse parseBookResource() {
    if (statusCode == 200) {
      return ApiResponse.success(S.scaffoldMessages.bookedResource());
    } else if (statusCode == 401) {
      return ApiResponse.unauthorized(RuntimeErrorType.authenticationError());
    } else if (statusCode == 403) {
      return ApiResponse.error(
          RuntimeErrorType.maxResourcesBooked(), "Max resources booked");
    } else if (statusCode == 409) {
      return ApiResponse.error(
          RuntimeErrorType.resourceBookCollision(), "Resource already booked");
    }

    return ApiResponse.error(RuntimeErrorType.unknownError(), "Unknown error");
  }

  ApiResponse parseUnbookResource() {
    if (statusCode == 200) {
      return ApiResponse.success(S.scaffoldMessages.unbookedResource());
    } else if (statusCode == 401) {
      return ApiResponse.unauthorized(RuntimeErrorType.authenticationError());
    } else if (statusCode == 404) {
      return ApiResponse.error(
          RuntimeErrorType.resourceUnavailable(), "Resource not found");
    }

    return ApiResponse.error(RuntimeErrorType.unknownError(), "Unknown error");
  }

  ApiResponse parseConfirmBooking() {
    if (statusCode == 200) {
      return ApiResponse.success(S.scaffoldMessages.confirmedBooking());
    } else if (statusCode == 404) {
      return ApiResponse.error(
          RuntimeErrorType.confirmBookingFailed(), "Confirm booking failed");
    }

    return ApiResponse.error(RuntimeErrorType.unknownError(), "Unknown error");
  }
}
