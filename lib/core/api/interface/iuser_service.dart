import 'package:tumble/core/api/apiservices/api_response.dart';
import 'package:tumble/core/models/api_models/kronox_user_model.dart';
import 'package:tumble/core/models/api_models/user_event_collection_model.dart';
import 'package:tumble/core/models/ui_models/school_model.dart';

abstract class IUserService {
  Future<ApiResponse> getUserEvents(String sessionToken);

  Future<ApiResponse> postUserLogin(
      String username, String password, String school);

  Future<ApiResponse> getRefreshSession(String refreshToken);

  Future<dynamic> putRegisterUserEvent(String eventId, String sessionToken);

  Future<dynamic> putUnregisterUserEvent(String eventId, String sessionToken);
}
