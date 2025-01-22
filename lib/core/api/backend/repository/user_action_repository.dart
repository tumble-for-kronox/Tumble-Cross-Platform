import 'package:tumble/core/api/backend/response_types/booking_response.dart';
import 'package:tumble/core/api/backend/response_types/user_response.dart';
import 'package:tumble/core/api/backend/interface/iuser_action_service.dart';
import 'package:tumble/core/api/backend/repository/backend_repository.dart';
import 'package:tumble/core/api/preferences/repository/preference_repository.dart';
import 'package:tumble/core/models/backend_models/resource_model.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';

class UserActionRepository implements IUserActionService {
  final _backendRepository = getIt<BackendRepository>();
  final _preferenceService = getIt<PreferenceRepository>();

  String? _getDefaultSchool() {
    return _preferenceService.defaultSchool;
  }

  @override
  Future<UserResponse> userEvents() async {
    return await _backendRepository.getUserEvents(_getDefaultSchool()!);
  }

  @override
  Future<UserResponse> userLogin(String username, String password, String school) async {
    return await _backendRepository.postUserLogin(username, password, school);
  }

  @override
  Future<UserResponse> registerUserEvent(String eventId) async {
    return await _backendRepository.putRegisterUserEvent(eventId, _getDefaultSchool()!);
  }

  @override
  Future<UserResponse> unregisterUserEvent(String eventId) async {
    return await _backendRepository.putUnregisterUserEvent(eventId, _getDefaultSchool()!);
  }

  @override
  Future<UserResponse> registerAllAvailableUserEvents() async {
    return await _backendRepository.putRegisterAllAvailableUserEvents(_getDefaultSchool()!);
  }

  @override
  Future<UserResponse> refreshSession() async {
    String? school = _getDefaultSchool();
    if (school != null) {
      return await _backendRepository.getRefreshSession(school);
    }
    return UserResponse.error('No school');
  }

  @override
  Future<BookingResponse> resourceAvailabilities(String resourceId, DateTime date) async {
    return await _backendRepository.getResourceAvailabilities(_getDefaultSchool()!, resourceId, date);
  }

  @override
  Future<BookingResponse> schoolResources() async {
    return await _backendRepository.getSchoolResources(_getDefaultSchool()!);
  }

  @override
  Future<BookingResponse> userBookings() async {
    return await _backendRepository.getUserBookings(_getDefaultSchool()!);
  }

  @override
  Future<BookingResponse> bookResources(String resourceId, DateTime date, AvailabilityValue bookingSlot) async {
    return await _backendRepository.putBookResource(_getDefaultSchool()!, resourceId, date, bookingSlot);
  }

  @override
  Future<BookingResponse> unbookResources(String bookingId) async {
    return await _backendRepository.putUnbookResource(_getDefaultSchool()!, bookingId);
  }

  @override
  Future<BookingResponse> confirmBooking(String resourceId, String bookingId) async {
    return await _backendRepository.putConfirmBooking(_getDefaultSchool()!, resourceId, bookingId);
  }
}
