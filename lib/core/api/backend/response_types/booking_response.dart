// ignore_for_file: constant_identifier_names

class BookingResponse<T> {
  ApiBookingResponseStatus status;
  T? data;
  String? message;

  BookingResponse.success(this.data) : status = ApiBookingResponseStatus.SUCCESS;

  BookingResponse.error(this.data) : status = ApiBookingResponseStatus.ERROR;

  BookingResponse.unauthorized(this.data) : status = ApiBookingResponseStatus.UNAUTHORIZED;

  BookingResponse.notFound(this.data) : status = ApiBookingResponseStatus.NOT_FOUND;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum ApiBookingResponseStatus { SUCCESS, ERROR, UNAUTHORIZED, NOT_FOUND }
