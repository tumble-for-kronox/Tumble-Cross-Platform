// ignore_for_file: constant_identifier_names

class ApiUserResponse<T> {
  ApiUserResponseStatus status;
  T? data;
  String? message;

  ApiUserResponse.authorized(this.data)
      : status = ApiUserResponseStatus.AUTHORIZED;

  ApiUserResponse.unauthorized(this.data)
      : status = ApiUserResponseStatus.UNAUTHORIZED;

  ApiUserResponse.completed(this.data)
      : status = ApiUserResponseStatus.COMPLETED;

  ApiUserResponse.error(this.data) : status = ApiUserResponseStatus.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum ApiUserResponseStatus { AUTHORIZED, UNAUTHORIZED, COMPLETED, ERROR }
