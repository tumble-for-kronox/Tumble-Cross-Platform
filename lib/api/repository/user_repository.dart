import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/api/apiservices/api_response.dart';
import 'package:tumble/api/interface/iuser_service.dart';
import 'package:tumble/api/repository/backend_repository.dart';
import 'package:tumble/database/repository/database_repository.dart';
import 'package:tumble/models/api_models/kronox_user_model.dart';
import 'package:tumble/models/api_models/user_event_collection_model.dart';
import 'package:tumble/shared/preference_types.dart';
import 'package:tumble/shared/secure_storage_keys.dart';
import 'package:tumble/startup/get_it_instances.dart';

class UserRepository implements IUserService {
  final _backendRepository = locator<BackendRepository>();
  final _sharedPrefs = locator<SharedPreferences>();
  final _databaseRepository = locator<DatabaseRepository>();
  final _secureStorage = locator<FlutterSecureStorage>();

  @override
  Future<ApiResponse<UserEventCollectionModel>> getUserEvents() async {
    final school = _sharedPrefs.getString(PreferenceTypes.school)!;
    final sessionToken = (await _databaseRepository.getUserSession())!.sessionToken;

    return await _backendRepository.getUserEvents(sessionToken, school);
  }

  @override
  Future<ApiResponse> postUserLogin(String? username, String? password) async {
    final school = _sharedPrefs.getString(PreferenceTypes.school)!;
    username ??= await _secureStorage.read(key: SecureStorageKeys.username);
    password ??= await _secureStorage.read(key: SecureStorageKeys.password);

    return await _backendRepository.postUserLogin(username!, password!, school);
  }

  @override
  Future putRegisterUserEvent(String eventId) async {
    final school = _sharedPrefs.getString(PreferenceTypes.school)!;
    final sessionToken = (await _databaseRepository.getUserSession())!.sessionToken;

    return await _backendRepository.putRegisterUserEvent(eventId, sessionToken, school);
  }

  @override
  Future putUnregisterUserEvent(String eventId) async {
    final school = _sharedPrefs.getString(PreferenceTypes.school)!;
    final sessionToken = (await _databaseRepository.getUserSession())!.sessionToken;

    return await _backendRepository.putUnregisterUserEvent(eventId, sessionToken, school);
  }
}
