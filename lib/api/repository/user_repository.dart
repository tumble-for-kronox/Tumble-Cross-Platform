import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/api/apiservices/api_response.dart';
import 'package:tumble/api/interface/iuser_service.dart';
import 'package:tumble/api/repository/backend_repository.dart';
import 'package:tumble/database/repository/database_repository.dart';
import 'package:tumble/startup/get_it_instances.dart';

class UserRepository implements IUserService {
  final _backendRepository = locator<BackendRepository>();
  final _databaseRepository = locator<DatabaseRepository>();

  @override
  Future<ApiResponse> getUserEvents() async {
    return ApiResponse.completed("temp");
  }

  @override
  Future postUserLogin(String username, String password) {
    // TODO: implement postUserLogin
    throw UnimplementedError();
  }

  @override
  Future putRegisterUserEvent(String eventId) {
    // TODO: implement putRegisterUserEvent
    throw UnimplementedError();
  }

  @override
  Future putUnregisterUserEvent(String eventId) {
    // TODO: implement putUnregisterUserEvent
    throw UnimplementedError();
  }
}
