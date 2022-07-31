import 'package:tumble/core/api/apiservices/api_response.dart';
import 'package:tumble/core/models/api_models/kronox_user_model.dart';
import 'package:tumble/core/models/api_models/user_event_collection_model.dart';

abstract class IUserService {
  Future<ApiResponse<UserEventCollectionModel>> getUserEvents();

  Future<ApiResponse<KronoxUserModel?>> postUserLogin(
      String username, String password);

  Future<dynamic> putRegisterUserEvent(String eventId);

  Future<dynamic> putUnregisterUserEvent(String eventId);
}
