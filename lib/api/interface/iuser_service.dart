import 'package:tumble/models/api_models/user_event_collection_model.dart';
import '../../models/api_models/kronox_user_model.dart';
import '../apiservices/api_response.dart';

abstract class IUserService {
  Future<ApiResponse<UserEventCollectionModel>> getUserEvents();

  Future<ApiResponse> postUserLogin(String username, String password);

  Future<dynamic> putRegisterUserEvent(String eventId);

  Future<dynamic> putUnregisterUserEvent(String eventId);
}
