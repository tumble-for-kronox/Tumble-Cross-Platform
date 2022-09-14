class ApiBookingResponse<T> {
  ApiBookingResponseStatus status;
  T? data;
  String? message;

  ApiBookingResponse.success(this.data) : status = ApiBookingResponseStatus.SUCCESS;

  ApiBookingResponse.error(this.data) : status = ApiBookingResponseStatus.ERROR;

  ApiBookingResponse.unauthorized(this.data) : status = ApiBookingResponseStatus.UNAUTHORIZED;

  ApiBookingResponse.notFound(this.data) : status = ApiBookingResponseStatus.NOT_FOUND;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum ApiBookingResponseStatus { SUCCESS, ERROR, UNAUTHORIZED, NOT_FOUND }
