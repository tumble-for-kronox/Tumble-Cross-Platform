// ignore_for_file: constant_identifier_names

class ScheduleOrProgrammeResponse<T> {
  ScheduleOrProgrammeStatus status;
  T? data;
  String? message;
  String? description;

  ScheduleOrProgrammeResponse.fetched(this.data) : status = ScheduleOrProgrammeStatus.FETCHED;

  ScheduleOrProgrammeResponse.cached(this.data) : status = ScheduleOrProgrammeStatus.CACHED;

  ScheduleOrProgrammeResponse.error(this.message, this.description) : status = ScheduleOrProgrammeStatus.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum ScheduleOrProgrammeStatus {
  FETCHED,
  ERROR,
  CACHED,
}
