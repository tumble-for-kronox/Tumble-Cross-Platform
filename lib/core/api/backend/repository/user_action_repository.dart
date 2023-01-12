import 'package:tumble/core/api/backend/response_types/api_response.dart';
import 'package:tumble/core/api/backend/repository/backend_repository.dart';
import 'package:tumble/core/api/preferences/repository/preference_repository.dart';
import 'package:tumble/core/models/backend_models/kronox_user_model.dart';
import 'package:tumble/core/models/backend_models/resource_model.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';

class UserActionRepository {
  final _backendRepository = getIt<BackendRepository>();
  final _preferenceService = getIt<PreferenceRepository>();

  Future<ApiResponse> userEvents() async =>
      await _backendRepository.getUserEvents(_preferenceService.defaultSchool!);

  Future<ApiResponse> userLogin(
          String username, String password, String school) async =>
      await _backendRepository.postUserLogin(username, password, school);

  Future<ApiResponse> registerUserEvent(String eventId) async =>
      await _backendRepository.putRegisterUserEvent(
          eventId, _preferenceService.defaultSchool!);

  Future<ApiResponse> unregisterUserEvent(String eventId) async =>
      await _backendRepository.putUnregisterUserEvent(
          eventId, _preferenceService.defaultSchool!);

  Future<ApiResponse> registerAllAvailableUserEvents() async =>
      await _backendRepository
          .putRegisterAll(_preferenceService.defaultSchool!);

  Future<ApiResponse> resourceAvailabilities(
          String resourceId, DateTime date) async =>
      await _backendRepository.getResourceAvailabilities(
          _preferenceService.defaultSchool!, resourceId, date);

  Future<ApiResponse> schoolResources() async => await _backendRepository
      .getSchoolResources(_preferenceService.defaultSchool!);

  Future<ApiResponse> userBookings() async => await _backendRepository
      .getUserBookings(_preferenceService.defaultSchool!);

  Future<ApiResponse> bookResources(String resourceId, DateTime date,
          AvailabilityValue bookingSlot) async =>
      await _backendRepository.putBookResource(
          _preferenceService.defaultSchool!, resourceId, date, bookingSlot);

  Future<ApiResponse> unbookResources(
          String bookingId, KronoxUserModel session) async =>
      await _backendRepository.putUnbookResource(
          _preferenceService.defaultSchool!, bookingId);

  Future<ApiResponse> confirmBooking(
          String resourceId, String bookingId) async =>
      await _backendRepository.putConfirmBooking(
          _preferenceService.defaultSchool!, resourceId, bookingId);
}
