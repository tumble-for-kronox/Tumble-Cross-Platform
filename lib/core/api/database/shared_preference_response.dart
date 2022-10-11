// ignore_for_file: constant_identifier_names

class SharedPreferenceResponse<T> {
  SharedPreferenceSchoolStatus status;
  T? data;
  String? message;

  SharedPreferenceResponse.noSchool(this.message) : status = SharedPreferenceSchoolStatus.NO_SCHOOL;

  SharedPreferenceResponse.schoolAvailable(this.data) : status = SharedPreferenceSchoolStatus.SCHOOL_AVAILABLE;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum SharedPreferenceSchoolStatus { NO_SCHOOL, SCHOOL_AVAILABLE }
