// ignore_for_file: constant_identifier_names

class ApiBugReportResponse<T> {
  ApiBugReportResponseStatus status;
  T? data;
  String? message;

  ApiBugReportResponse.success(this.data)
      : status = ApiBugReportResponseStatus.SUCCESS;

  ApiBugReportResponse.error(this.message)
      : status = ApiBugReportResponseStatus.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum ApiBugReportResponseStatus {
  SUCCESS,
  ERROR,
}
