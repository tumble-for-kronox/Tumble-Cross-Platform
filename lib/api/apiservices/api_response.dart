// ignore_for_file: constant_identifier_names

class ApiResponse<T> {
  ApiStatus status;
  T? data;
  String? message;

  ApiResponse.completed(this.data) : status = ApiStatus.REQUESTED;

  ApiResponse.cached(this.data) : status = ApiStatus.CACHED;

  ApiResponse.error(this.message) : status = ApiStatus.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum ApiStatus { INITIAL, LOADING, REQUESTED, ERROR, CACHED }
