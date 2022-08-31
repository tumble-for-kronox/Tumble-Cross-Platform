import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/apiservices/api_schedule_or_programme_response.dart';
import 'package:tumble/core/api/apiservices/api_user_response.dart';
import 'package:tumble/core/api/interface/iuser_service.dart';
import 'package:tumble/core/api/repository/backend_repository.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';

class UserRepository implements IUserService {
  final _backendRepository = getIt<BackendRepository>();

  @override
  Future<ApiUserResponse> getUserEvents(String sessionToken) async {
    final school =
        getIt<SharedPreferences>().getString(PreferenceTypes.school)!;

    return await _backendRepository.getUserEvents(sessionToken, school);
  }

  @override
  Future<ApiUserResponse> postUserLogin(
      String username, String password, String school) async {
    return await _backendRepository.postUserLogin(username, password, school);
  }

  @override
  Future<ApiUserResponse> putRegisterUserEvent(
      String eventId, String sessionToken) async {
    final school =
        getIt<SharedPreferences>().getString(PreferenceTypes.school)!;

    return await _backendRepository.putRegisterUserEvent(
        eventId, sessionToken, school);
  }

  @override
  Future<ApiUserResponse> putUnregisterUserEvent(
      String eventId, String sessionToken) async {
    final school =
        getIt<SharedPreferences>().getString(PreferenceTypes.school)!;

    return await _backendRepository.putUnregisterUserEvent(
        eventId, sessionToken, school);
  }

  @override
  Future<ApiUserResponse> putRegisterAllAvailableUserEvents(
      String sessionToken) async {
    final school =
        getIt<SharedPreferences>().getString(PreferenceTypes.school)!;
    return await _backendRepository.putRegisterAllAvailableUserEvents(
        sessionToken, school);
  }

  @override
  Future<ApiUserResponse> getRefreshSession(String refreshToken) async {
    String? school =
        getIt<SharedPreferences>().getString(PreferenceTypes.school);
    if (school != null) {
      return await _backendRepository.getRefreshSession(refreshToken, school);
    }
    return ApiUserResponse.error('No school');
  }
}
