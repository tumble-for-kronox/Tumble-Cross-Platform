import 'package:tumble/core/api/backend/response_types/booking_response.dart';
import 'package:tumble/core/api/backend/response_types/refresh_response.dart';
import 'package:tumble/core/api/backend/response_types/user_response.dart';
import 'package:tumble/core/api/backend/interface/iuser_action_service.dart';
import 'package:tumble/core/api/backend/repository/backend_repository.dart';
import 'package:tumble/core/api/preferences/repository/preference_repository.dart';
import 'package:tumble/core/models/backend_models/kronox_user_model.dart';
import 'package:tumble/core/models/backend_models/resource_model.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/extensions/extensions.dart';

class UserActionRepository implements IUserActionService {
  final _backendRepository = getIt<BackendRepository>();
  final _preferenceService = getIt<PreferenceRepository>();

  String? _getDefaultSchool() {
    return _preferenceService.defaultSchool;
  }

  @override
  Future<RefreshResponse<UserResponse>> userEvents(KronoxUserModel session) async {
    UserResponse resp = await _backendRepository.getUserEvents(session.sessionToken, _getDefaultSchool()!);

    UserResponse sessionRefresh = await resp.autoRefreshSession(refreshSession, session);

    if (_checkUserResponseStatus(resp, sessionRefresh)) {
      resp = await _backendRepository.getUserEvents(
          (sessionRefresh.data as KronoxUserModel).sessionToken, _getDefaultSchool()!);
    }

    return RefreshResponse(resp, sessionRefresh);
  }

  @override
  Future<UserResponse> userLogin(String username, String password, String school) async {
    return await _backendRepository.postUserLogin(username, password, school);
  }

  @override
  Future<RefreshResponse<UserResponse>> registerUserEvent(String eventId, KronoxUserModel session) async {
    UserResponse resp =
        await _backendRepository.putRegisterUserEvent(eventId, session.sessionToken, _getDefaultSchool()!);

    UserResponse sessionRefresh = await resp.autoRefreshSession(refreshSession, session);

    if (_checkUserResponseStatus(resp, sessionRefresh)) {
      resp = await _backendRepository.putRegisterUserEvent(
          eventId, (sessionRefresh.data as KronoxUserModel).sessionToken, _getDefaultSchool()!);
    }

    return RefreshResponse(resp, sessionRefresh);
  }

  @override
  Future<RefreshResponse<UserResponse>> unregisterUserEvent(String eventId, KronoxUserModel session) async {
    UserResponse resp =
        await _backendRepository.putUnregisterUserEvent(eventId, session.sessionToken, _getDefaultSchool()!);

    UserResponse sessionRefresh = await resp.autoRefreshSession(refreshSession, session);

    if (_checkUserResponseStatus(resp, sessionRefresh)) {
      resp = await _backendRepository.putUnregisterUserEvent(
          eventId, (sessionRefresh.data as KronoxUserModel).sessionToken, _getDefaultSchool()!);
    }

    return RefreshResponse(resp, sessionRefresh);
  }

  @override
  Future<RefreshResponse<UserResponse>> registerAllAvailableUserEvents(KronoxUserModel session) async {
    UserResponse resp =
        await _backendRepository.putRegisterAllAvailableUserEvents(session.sessionToken, _getDefaultSchool()!);

    UserResponse sessionRefresh = await resp.autoRefreshSession(refreshSession, session);

    if (_checkUserResponseStatus(resp, sessionRefresh)) {
      resp = await _backendRepository.putRegisterAllAvailableUserEvents(
          (sessionRefresh.data as KronoxUserModel).sessionToken, _getDefaultSchool()!);
    }

    return RefreshResponse(resp, sessionRefresh);
  }

  @override
  Future<UserResponse> refreshSession(String refreshToken) async {
    String? school = _getDefaultSchool();
    if (school != null) {
      return await _backendRepository.getRefreshSession(refreshToken, school);
    }
    return UserResponse.error('No school');
  }

  @override
  Future<RefreshResponse<BookingResponse>> resourceAvailabilities(
      String resourceId, DateTime date, KronoxUserModel session) async {
    BookingResponse resp = await _backendRepository.getResourceAvailabilities(
        session.sessionToken, _getDefaultSchool()!, resourceId, date);

    UserResponse sessionRefresh = await resp.autoRefreshSession(refreshSession, session);

    if (_checkBookingResponseStatus(resp, sessionRefresh)) {
      resp = await _backendRepository.getResourceAvailabilities(
          (sessionRefresh.data as KronoxUserModel).sessionToken, _getDefaultSchool()!, resourceId, date);
    }

    return RefreshResponse(resp, sessionRefresh);
  }

  @override
  Future<RefreshResponse<BookingResponse>> schoolResources(KronoxUserModel session) async {
    BookingResponse resp = await _backendRepository.getSchoolResources(session.sessionToken, _getDefaultSchool()!);

    UserResponse sessionRefresh = await resp.autoRefreshSession(refreshSession, session);

    if (_checkBookingResponseStatus(resp, sessionRefresh)) {
      resp = await _backendRepository.getSchoolResources(
          (sessionRefresh.data as KronoxUserModel).sessionToken, _getDefaultSchool()!);
    }

    return RefreshResponse(resp, sessionRefresh);
  }

  @override
  Future<RefreshResponse<BookingResponse>> userBookings(KronoxUserModel session) async {
    BookingResponse resp = await _backendRepository.getUserBookings(session.sessionToken, _getDefaultSchool()!);

    UserResponse sessionRefresh = await resp.autoRefreshSession(refreshSession, session);

    if (_checkBookingResponseStatus(resp, sessionRefresh)) {
      resp = await _backendRepository.getUserBookings(
          (sessionRefresh.data as KronoxUserModel).sessionToken, _getDefaultSchool()!);
    }

    return RefreshResponse(resp, sessionRefresh);
  }

  @override
  Future<RefreshResponse<BookingResponse>> bookResources(
      String resourceId, DateTime date, AvailabilityValue bookingSlot, KronoxUserModel session) async {
    BookingResponse resp = await _backendRepository.putBookResource(
        session.sessionToken, _getDefaultSchool()!, resourceId, date, bookingSlot);

    UserResponse sessionRefresh = await resp.autoRefreshSession(refreshSession, session);

    if (_checkBookingResponseStatus(resp, sessionRefresh)) {
      resp = await _backendRepository.putBookResource(
          (sessionRefresh.data as KronoxUserModel).sessionToken, _getDefaultSchool()!, resourceId, date, bookingSlot);
    }

    return RefreshResponse(resp, sessionRefresh);
  }

  @override
  Future<RefreshResponse<BookingResponse>> unbookResources(String bookingId, KronoxUserModel session) async {
    BookingResponse resp =
        await _backendRepository.putUnbookResource(session.sessionToken, _getDefaultSchool()!, bookingId);

    UserResponse sessionRefresh = await resp.autoRefreshSession(refreshSession, session);

    if (_checkBookingResponseStatus(resp, sessionRefresh)) {
      resp = await _backendRepository.putUnbookResource(
          (sessionRefresh.data as KronoxUserModel).sessionToken, _getDefaultSchool()!, bookingId);
    }

    return RefreshResponse(resp, sessionRefresh);
  }

  @override
  Future<RefreshResponse<BookingResponse>> confirmBooking(
      String resourceId, String bookingId, KronoxUserModel session) async {
    BookingResponse resp =
        await _backendRepository.putConfirmBooking(session.sessionToken, _getDefaultSchool()!, resourceId, bookingId);

    UserResponse sessionRefresh = await resp.autoRefreshSession(refreshSession, session);

    if (_checkBookingResponseStatus(resp, sessionRefresh)) {
      resp = await _backendRepository.putConfirmBooking(
          (sessionRefresh.data as KronoxUserModel).sessionToken, _getDefaultSchool()!, resourceId, bookingId);
    }

    return RefreshResponse(resp, sessionRefresh);
  }

  bool _checkUserResponseStatus(UserResponse resp, UserResponse sessionRefresh) {
    return (resp.status != ApiUserResponseStatus.COMPLETED || resp.status != ApiUserResponseStatus.AUTHORIZED) &&
        sessionRefresh.status == ApiUserResponseStatus.AUTHORIZED;
  }

  bool _checkBookingResponseStatus(BookingResponse resp, UserResponse sessionRefresh) {
    return (resp.status != ApiBookingResponseStatus.SUCCESS) &&
        sessionRefresh.status == ApiUserResponseStatus.AUTHORIZED;
  }
}
