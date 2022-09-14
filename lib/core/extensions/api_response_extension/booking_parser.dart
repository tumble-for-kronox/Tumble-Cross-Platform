import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';
import 'package:tumble/core/api/apiservices/api_booking_response.dart';
import 'package:tumble/core/api/apiservices/api_bug_report_response.dart';
import 'package:tumble/core/api/apiservices/api_user_response.dart';
import 'package:tumble/core/models/api_models/resource_model.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

import '../../api/apiservices/runtime_error_type.dart';

extension BookingResponseParsing on Response {
  ApiBookingResponse parseSchoolResource() {
    if (statusCode == 200) {
      List<dynamic> jsonList = json.decode(body);
      List<ResourceModel> schoolResources = List<ResourceModel>.from(jsonList.map((e) => resourceModelFromJson(e)));
      return ApiBookingResponse.success(schoolResources);
    } else if (statusCode == 401) {
      return ApiBookingResponse.unauthorized(RuntimeErrorType.authenticationError());
    } else if (statusCode == 404) {
      return ApiBookingResponse.notFound(RuntimeErrorType.resourceUnavailable());
    }

    return ApiBookingResponse.error(RuntimeErrorType.unknownError());
  }

  Future<ApiBookingResponse> parseUserBookings() async {
    if (statusCode == 200) {
      List<dynamic> jsonList = json.decode(body);
      List<Booking> userBookings = List<Booking>.from(jsonList.map((x) => Booking.fromJson(x)));
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
      return ApiBookingResponse.error(RuntimeErrorType.authenticationError());
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
}

extension BookingHttpClientResponseParsing on HttpClientResponse {
  Future<ApiBookingResponse> parseSchoolResource() async {
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
      return ApiBookingResponse.error(RuntimeErrorType.authenticationError());
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
}
