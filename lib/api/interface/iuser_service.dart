import '../apiservices/api_response.dart';

abstract class IUserService {
  Future<ApiResponse> getUserEvents();

  Future<dynamic> postUserLogin(String username, String password);

  Future<dynamic> putRegisterUserEvent(String eventId);

  Future<dynamic> putUnregisterUserEvent(String eventId);
}
