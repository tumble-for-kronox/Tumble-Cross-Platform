// ignore_for_file: constant_identifier_names

class ScheduleOrProgrammeResponse<T> {
  ApiScheduleOrProgrammeStatus status;
  T? data;
  String? message;

  ScheduleOrProgrammeResponse.fetched(this.data) : status = ApiScheduleOrProgrammeStatus.FETCHED;

  ScheduleOrProgrammeResponse.cached(this.data) : status = ApiScheduleOrProgrammeStatus.CACHED;

  ScheduleOrProgrammeResponse.error(this.message) : status = ApiScheduleOrProgrammeStatus.ERROR;

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
  CACHED,
}
