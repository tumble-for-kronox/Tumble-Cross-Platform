import 'package:tumble/models/api_models/user_event_collection_model.dart';
import '../../models/api_models/kronox_user_model.dart';
import '../apiservices/api_response.dart';

abstract class IUserService {
  Future<ApiResponse> getUserEvents(String sessionToken);

  Future<ApiResponse> postUserLogin(String username, String password);

  Future<ApiResponse> getRefreshSession(String refreshToken);

  Future<dynamic> putRegisterUserEvent(String eventId, String sessionToken);

  Future<dynamic> putUnregisterUserEvent(String eventId, String sessionToken);
}
