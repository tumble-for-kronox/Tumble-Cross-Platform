// ignore_for_file: constant_identifier_names

class SharedPreferenceResponse<T> {
  InitialStatus status;
  T? data;
  String? message;

  SharedPreferenceResponse.noSchool(this.message)
      : status = InitialStatus.NO_SCHOOL;

  SharedPreferenceResponse.schoolAvailable(this.data)
      : status = InitialStatus.SCHOOL_AVAILABLE;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum InitialStatus { NO_SCHOOL, SCHOOL_AVAILABLE }
