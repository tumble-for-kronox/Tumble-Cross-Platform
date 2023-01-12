// ignore_for_file: constant_identifier_names

class ApiResponse<T> {
  ApiResponseStatus status;
  T? data;
  String? message;
  String? description;

  ApiResponse.cached(this.data) : status = ApiResponseStatus.cached;

  ApiResponse.success(this.data) : status = ApiResponseStatus.success;

  ApiResponse.error(this.message, this.description)
      : status = ApiResponseStatus.error;

  ApiResponse.fetched(this.data) : status = ApiResponseStatus.fetched;

  ApiResponse.authorized(this.data) : status = ApiResponseStatus.authorized;

  ApiResponse.unauthorized(this.data) : status = ApiResponseStatus.unauthorized;

  ApiResponse.notFound(this.data) : status = ApiResponseStatus.missing;

  ApiResponse.forbidden(this.message, this.description)
      : status = ApiResponseStatus.forbidden;

  ApiResponse.completed(this.data) : status = ApiResponseStatus.completed;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum ApiResponseStatus {
  cached,
  success,
  error,
  fetched,
  authorized,
  unauthorized,
  missing,
  forbidden,
  completed
}
