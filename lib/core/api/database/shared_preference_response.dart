// ignore_for_file: constant_identifier_names

class SharedPreferenceResponse<T> {
  SharedPreferenceSchoolStatus status;
  T? data;
  String? message;

  SharedPreferenceResponse.firstBoot(this.message)
      : status = SharedPreferenceSchoolStatus.INITIAL;

  SharedPreferenceResponse.notFirstBoot(this.data)
      : status = SharedPreferenceSchoolStatus.SCHOOL_AVAILABLE;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum SharedPreferenceSchoolStatus { INITIAL, SCHOOL_AVAILABLE }
