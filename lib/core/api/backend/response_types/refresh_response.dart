import 'package:tumble/core/api/backend/response_types/user_response.dart';
import 'package:tumble/core/models/backend_models/kronox_user_model.dart';

class RefreshResponse<T> {
  T data;
  UserResponse refreshResp;

  RefreshResponse(this.data, this.refreshResp);
}
