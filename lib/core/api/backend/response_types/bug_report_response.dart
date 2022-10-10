// ignore_for_file: constant_identifier_names

class BugReportResponse<T> {
  ApiBugReportResponseStatus status;
  T? data;
  String? message;

  BugReportResponse.success(this.data) : status = ApiBugReportResponseStatus.SUCCESS;

  BugReportResponse.error(this.message) : status = ApiBugReportResponseStatus.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum ApiBugReportResponseStatus { SUCCESS, ERROR }
