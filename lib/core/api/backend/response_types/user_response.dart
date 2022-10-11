// ignore_for_file: constant_identifier_names

class UserResponse<T> {
  ApiUserResponseStatus status;
  T? data;
  String? message;

  UserResponse.authorized(this.data) : status = ApiUserResponseStatus.AUTHORIZED;

  UserResponse.unauthorized(this.data) : status = ApiUserResponseStatus.UNAUTHORIZED;

  UserResponse.completed(this.data) : status = ApiUserResponseStatus.COMPLETED;

  UserResponse.error(this.data) : status = ApiUserResponseStatus.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum ApiUserResponseStatus { AUTHORIZED, UNAUTHORIZED, COMPLETED, ERROR }
