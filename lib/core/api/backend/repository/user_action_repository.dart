import 'package:tumble/core/api/backend/response_types/booking_response.dart';
import 'package:tumble/core/api/backend/response_types/user_response.dart';
import 'package:tumble/core/api/backend/interface/iuser_action_service.dart';
import 'package:tumble/core/api/backend/repository/backend_repository.dart';
import 'package:tumble/core/api/preferences/repository/preference_repository.dart';
import 'package:tumble/core/models/backend_models/resource_model.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';

class UserActionRepository implements IUserActionService {
  final _backendRepository = getIt<BackendRepository>();
  final _preferenceService = getIt<PreferenceRepository>();

  String? _getDefaultSchool() {
    return _preferenceService.defaultSchool;
  }

  @override
  Future<UserResponse> userEvents(String sessionToken) async {
    return await _backendRepository.getUserEvents(sessionToken, _getDefaultSchool()!);
  }

  @override
  Future<UserResponse> userLogin(String username, String password, String school) async {
    return await _backendRepository.postUserLogin(username, password, school);
  }

  @override
  Future<UserResponse> registerUserEvent(String eventId, String sessionToken) async {
    return await _backendRepository.putRegisterUserEvent(eventId, sessionToken, _getDefaultSchool()!);
  }

  @override
  Future<UserResponse> unregisterUserEvent(String eventId, String sessionToken) async {
    return await _backendRepository.putUnregisterUserEvent(eventId, sessionToken, _getDefaultSchool()!);
  }

  @override
  Future<UserResponse> registerAllAvailableUserEvents(String sessionToken) async {
    return await _backendRepository.putRegisterAllAvailableUserEvents(sessionToken, _getDefaultSchool()!);
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
  Future<BookingResponse> resourceAvailabilities(String resourceId, DateTime date, String sessionToken) async {
    return await _backendRepository.getResourceAvailabilities(sessionToken, _getDefaultSchool()!, resourceId, date);
  }

  @override
  Future<BookingResponse> schoolResources(String sessionToken) async {
    return await _backendRepository.getSchoolResources(sessionToken, _getDefaultSchool()!);
  }

  @override
  Future<BookingResponse> userBookings(String sessionToken) async {
    return await _backendRepository.getUserBookings(sessionToken, _getDefaultSchool()!);
  }

  @override
  Future<BookingResponse> bookResources(
      String resourceId, DateTime date, AvailabilityValue bookingSlot, String sessionToken) async {
    return await _backendRepository.putBookResource(sessionToken, _getDefaultSchool()!, resourceId, date, bookingSlot);
  }

  @override
  Future<BookingResponse> unbookResources(String sessionToken, String bookingId) async {
    return await _backendRepository.putUnbookResource(sessionToken, _getDefaultSchool()!, bookingId);
  }

  @override
  Future<BookingResponse> confirmBooking(String sessionToken, String resourceId, String bookingId) async {
    return await _backendRepository.putConfirmBooking(sessionToken, _getDefaultSchool()!, resourceId, bookingId);
  }
}
