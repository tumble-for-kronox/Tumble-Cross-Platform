import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/apiservices/api_response.dart';
import 'package:tumble/core/api/interface/iuser_service.dart';
import 'package:tumble/core/api/repository/backend_repository.dart';
import 'package:tumble/core/database/repository/database_repository.dart';
import 'package:tumble/core/models/api_models/kronox_user_model.dart';
import 'package:tumble/core/models/api_models/user_event_collection_model.dart';
import 'package:tumble/core/models/ui_models/school_model.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/shared/secure_storage_keys.dart';
import 'package:tumble/core/startup/get_it_instances.dart';

import '../../database/repository/secure_storage_repository.dart';

class UserRepository implements IUserService {
  final _backendRepository = locator<BackendRepository>();
  final _sharedPrefs = locator<SharedPreferences>();
  final _secureStorage = locator<SecureStorageRepository>();

  @override
  Future<ApiResponse> getUserEvents(String sessionToken) async {
    final school = _sharedPrefs.getString(PreferenceTypes.school)!;

    return await _backendRepository.getUserEvents(sessionToken, school);
  }

  @override
  Future<ApiResponse> postUserLogin(
      String username, String password, School school) async {
    return await _backendRepository.postUserLogin(
        username, password, school.schoolName);
  }

  @override
  Future putRegisterUserEvent(String eventId, String sessionToken) async {
    final school = _sharedPrefs.getString(PreferenceTypes.school)!;

    return await _backendRepository.putRegisterUserEvent(
        eventId, sessionToken, school);
  }

  @override
  Future putUnregisterUserEvent(String eventId, String sessionToken) async {
    final school = _sharedPrefs.getString(PreferenceTypes.school)!;

    return await _backendRepository.putUnregisterUserEvent(
        eventId, sessionToken, school);
  }

  @override
  Future<ApiResponse> getRefreshSession(String refreshToken) async {
    final school = _sharedPrefs.getString(PreferenceTypes.school)!;

    return await _backendRepository.getRefreshSession(refreshToken, school);
  }
}
