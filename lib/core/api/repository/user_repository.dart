import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/apiservices/api_booking_response.dart';
import 'package:tumble/core/api/apiservices/api_schedule_or_programme_response.dart';
import 'package:tumble/core/api/apiservices/api_user_response.dart';
import 'package:tumble/core/api/interface/iuser_service.dart';
import 'package:tumble/core/api/repository/backend_repository.dart';
import 'package:tumble/core/models/api_models/resource_model.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';

class UserRepository implements IUserService {
  final _backendRepository = getIt<BackendRepository>();
  final _sharedPrefs = getIt<SharedPreferences>();

  String? _getDefaultSchool() {
    return _sharedPrefs.getString(PreferenceTypes.school);
  }

  @override
  Future<ApiUserResponse> getUserEvents(String sessionToken) async {
    return await _backendRepository.getUserEvents(sessionToken, _getDefaultSchool()!);
  }

  @override
  Future<ApiUserResponse> postUserLogin(String username, String password, String school) async {
    return await _backendRepository.postUserLogin(username, password, school);
  }

  @override
  Future<ApiUserResponse> putRegisterUserEvent(String eventId, String sessionToken) async {
    return await _backendRepository.putRegisterUserEvent(eventId, sessionToken, _getDefaultSchool()!);
  }

  @override
  Future<ApiUserResponse> putUnregisterUserEvent(String eventId, String sessionToken) async {
    return await _backendRepository.putUnregisterUserEvent(eventId, sessionToken, _getDefaultSchool()!);
  }

  @override
  Future<ApiUserResponse> putRegisterAllAvailableUserEvents(String sessionToken) async {
    return await _backendRepository.putRegisterAllAvailableUserEvents(sessionToken, _getDefaultSchool()!);
  }

  @override
  Future<ApiUserResponse> getRefreshSession(String refreshToken) async {
    String? school = _getDefaultSchool();
    if (school != null) {
      return await _backendRepository.getRefreshSession(refreshToken, school);
    }
    return ApiUserResponse.error('No school');
  }

  @override
  Future<ApiBookingResponse> getResourceAvailabilities(String resourceId, DateTime date, String sessionToken) async {
    return await _backendRepository.getResourceAvailabilities(sessionToken, _getDefaultSchool()!, resourceId, date);
  }

  @override
  Future<ApiBookingResponse> getSchoolResources(String sessionToken) async {
    return await _backendRepository.getSchoolResources(sessionToken, _getDefaultSchool()!);
  }

  @override
  Future<ApiBookingResponse> getUserBookings(String sessionToken) async {
    return await _backendRepository.getUserBookings(sessionToken, _getDefaultSchool()!);
  }

  @override
  Future<ApiBookingResponse> putBookResources(
      String resourceId, DateTime date, AvailabilityValue bookingSlot, String sessionToken) async {
    return await _backendRepository.putBookResource(sessionToken, _getDefaultSchool()!, resourceId, date, bookingSlot);
  }

  @override
  Future<ApiBookingResponse> putUnbookResources(String bookingId, String sessionToken) async {
    return await _backendRepository.putUnbookResource(sessionToken, _getDefaultSchool()!, bookingId);
  }
}
