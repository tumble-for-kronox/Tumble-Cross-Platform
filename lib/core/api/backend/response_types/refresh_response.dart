import 'package:tumble/core/api/backend/response_types/user_response.dart';

class RefreshResponse<T> {
  T data;
  UserResponse refreshResp;

  RefreshResponse(this.data, this.refreshResp);
}
