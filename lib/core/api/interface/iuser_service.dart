import 'package:flutter/foundation.dart';
import 'package:tumble/core/api/apiservices/api_response.dart';

@immutable
abstract class IUserService {
  Future<ApiResponse> getUserEvents(String sessionToken);

  Future<ApiResponse> postUserLogin(
      String username, String password, String school);

  Future<ApiResponse> getRefreshSession(String refreshToken);

  Future<dynamic> putRegisterUserEvent(String eventId, String sessionToken);

  Future<dynamic> putUnregisterUserEvent(String eventId, String sessionToken);
}
