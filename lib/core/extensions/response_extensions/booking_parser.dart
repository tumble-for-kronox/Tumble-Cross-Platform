import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:tumble/core/api/backend/response_types/booking_response.dart';
import 'package:tumble/core/api/backend/response_types/runtime_error_type.dart';
import 'package:tumble/core/models/backend_models/resource_model.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

extension BookingResponseParsing on Response {
  BookingResponse parseSchoolResources() {
    if (statusCode == 200) {
      List<ResourceModel> schoolResources =
          List<ResourceModel>.from(data.map((e) => resourceModelFromJson(jsonEncode(e))));
      return BookingResponse.success(schoolResources);
    } else if (statusCode == 401) {
      return BookingResponse.unauthorized(RuntimeErrorType.authenticationError());
    } else if (statusCode == 404) {
      return BookingResponse.notFound(RuntimeErrorType.resourceUnavailable());
    }

    return BookingResponse.error(RuntimeErrorType.unknownError());
  }

  BookingResponse parseSchoolResource() {
    if (statusCode == 200) {
      return BookingResponse.success(resourceModelFromJson(jsonEncode(data)));
    } else if (statusCode == 401) {
      return BookingResponse.unauthorized(RuntimeErrorType.authenticationError());
    } else if (statusCode == 404) {
      return BookingResponse.notFound(RuntimeErrorType.resourceUnavailable());
    }

    return BookingResponse.error(RuntimeErrorType.unknownError());
  }

  Future<BookingResponse> parseUserBookings() async {
    if (statusCode == 200) {
      List<dynamic> jsonList = json.decode(jsonEncode(data));
      List<Booking> userBookings = List<Booking>.from(jsonList.map((x) => Booking.fromJson(x)));
      return BookingResponse.success(userBookings);
    } else if (statusCode == 401) {
      return BookingResponse.unauthorized(RuntimeErrorType.authenticationError());
    }

    return BookingResponse.error(RuntimeErrorType.unknownError());
  }

  BookingResponse parseBookResource() {
    if (statusCode == 200) {
      return BookingResponse.success(S.scaffoldMessages.bookedResource());
    } else if (statusCode == 401) {
      return BookingResponse.unauthorized(RuntimeErrorType.authenticationError());
    } else if (statusCode == 403) {
      return BookingResponse.error(RuntimeErrorType.maxResourcesBooked());
    } else if (statusCode == 409) {
      return BookingResponse.error(RuntimeErrorType.resourceBookCollision());
    }

    return BookingResponse.error(RuntimeErrorType.unknownError());
  }

  BookingResponse parseUnbookResource() {
    if (statusCode == 200) {
      return BookingResponse.success(S.scaffoldMessages.unbookedResource());
    } else if (statusCode == 401) {
      return BookingResponse.unauthorized(RuntimeErrorType.authenticationError());
    } else if (statusCode == 404) {
      return BookingResponse.error(RuntimeErrorType.resourceUnavailable());
    }

    return BookingResponse.error(RuntimeErrorType.unknownError());
  }

  BookingResponse parseConfirmBooking() {
    if (statusCode == 200) {
      return BookingResponse.success(S.scaffoldMessages.confirmedBooking());
    } else if (statusCode == 404) {
      return BookingResponse.error(RuntimeErrorType.confirmBookingFailed());
    }

    return BookingResponse.error(RuntimeErrorType.unknownError());
  }
}
/* 
extension BookingHttpClientResponseParsing on HttpClientResponse {
  Future<ApiBookingResponse> parseSchoolResources() async {
    if (statusCode == 200) {
      List<dynamic> jsonList = json.decode(await transform(utf8.decoder).join());
      List<ResourceModel> schoolResources = List<ResourceModel>.from(jsonList.map((e) => ResourceModel.fromJson(e)));
      return ApiBookingResponse.success(schoolResources);
    } else if (statusCode == 401) {
      return ApiBookingResponse.unauthorized(RuntimeErrorType.authenticationError());
    } else if (statusCode == 404) {
      return ApiBookingResponse.notFound(RuntimeErrorType.resourceUnavailable());
    }
    return ApiBookingResponse.error(RuntimeErrorType.unknownError());
  }

  Future<ApiBookingResponse> parseSchoolResource() async {
    if (statusCode == 200) {
      return ApiBookingResponse.success(resourceModelFromJson(await transform(utf8.decoder).join()));
    } else if (statusCode == 401) {
      return ApiBookingResponse.unauthorized(RuntimeErrorType.authenticationError());
    } else if (statusCode == 404) {
      return ApiBookingResponse.notFound(RuntimeErrorType.resourceUnavailable());
    }
    return ApiBookingResponse.error(RuntimeErrorType.unknownError());
  }

  Future<ApiBookingResponse> parseUserBookings() async {
    if (statusCode == 200) {
      List<dynamic> jsonList = json.decode(await transform(utf8.decoder).join());
      List<Booking> userBookings = List<Booking>.from(jsonList.map((e) => Booking.fromJson(e)));
      return ApiBookingResponse.success(userBookings);
    } else if (statusCode == 401) {
      return ApiBookingResponse.unauthorized(RuntimeErrorType.authenticationError());
    }

    return ApiBookingResponse.error(RuntimeErrorType.unknownError());
  }

  ApiBookingResponse parseBookResource() {
    if (statusCode == 200) {
      return ApiBookingResponse.success(S.scaffoldMessages.bookedResource());
    } else if (statusCode == 401) {
      return ApiBookingResponse.unauthorized(RuntimeErrorType.authenticationError());
    } else if (statusCode == 403) {
      return ApiBookingResponse.error(RuntimeErrorType.maxResourcesBooked());
    } else if (statusCode == 409) {
      return ApiBookingResponse.error(RuntimeErrorType.resourceBookCollision());
    }

    return ApiBookingResponse.error(RuntimeErrorType.unknownError());
  }

  ApiBookingResponse parseUnbookResource() {
    if (statusCode == 200) {
      return ApiBookingResponse.success(S.scaffoldMessages.unbookedResource());
    } else if (statusCode == 401) {
      return ApiBookingResponse.unauthorized(RuntimeErrorType.authenticationError());
    } else if (statusCode == 404) {
      return ApiBookingResponse.error(RuntimeErrorType.resourceUnavailable());
    }

    return ApiBookingResponse.error(RuntimeErrorType.unknownError());
  }

  ApiBookingResponse parseConfirmBooking() {
    if (statusCode == 200) {
      return ApiBookingResponse.success(S.scaffoldMessages.confirmedBooking());
    } else if (statusCode == 404) {
      return ApiBookingResponse.error(RuntimeErrorType.confirmBookingFailed());
    }

    return ApiBookingResponse.error(RuntimeErrorType.unknownError());
  }
}
 */