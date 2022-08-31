// ignore_for_file: constant_identifier_names

class ApiScheduleOrProgrammeResponse<T> {
  ApiScheduleOrProgrammeStatus status;
  T? data;
  String? message;

  ApiScheduleOrProgrammeResponse.completed(this.data)
      : status = ApiScheduleOrProgrammeStatus.FETCHED;

  ApiScheduleOrProgrammeResponse.cached(this.data)
      : status = ApiScheduleOrProgrammeStatus.CACHED;

  ApiScheduleOrProgrammeResponse.error(this.message)
      : status = ApiScheduleOrProgrammeStatus.ERROR;

  /* ApiScheduleOrProgrammeResponse.unauthorized(this.message)
      : status = ApiStatus.UNAUTHORIZED;
 */
  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum ApiScheduleOrProgrammeStatus {
  FETCHED,
  ERROR,
  CACHED, /* UNAUTHORIZED, SENT_BUG */
}
