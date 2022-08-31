import 'package:flutter/foundation.dart';
import 'package:tumble/core/api/apiservices/api_schedule_or_programme_response.dart';
import 'package:tumble/core/api/apiservices/api_user_response.dart';

@immutable
abstract class IUserService {
  Future<ApiUserResponse> getUserEvents(String sessionToken);

  Future<ApiUserResponse> postUserLogin(
      String username, String password, String school);

  Future<ApiUserResponse> getRefreshSession(String refreshToken);

  Future<ApiUserResponse> putRegisterAllAvailableUserEvents(
      String sessionToken);

  Future<ApiUserResponse> putRegisterUserEvent(
      String eventId, String sessionToken);

  Future<ApiUserResponse> putUnregisterUserEvent(
      String eventId, String sessionToken);
}
