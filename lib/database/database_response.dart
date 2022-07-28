class DatabaseResponse<T> {
  Status status;
  T? data;
  String? message;

  DatabaseResponse.initial(this.message) : status = Status.NO_SCHOOL;

  DatabaseResponse.hasDefault(this.data) : status = Status.HAS_SCHOOL;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

// ignore: constant_identifier_names
enum Status { NO_SCHOOL, HAS_SCHOOL }
