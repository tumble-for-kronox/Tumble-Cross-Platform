class DatabaseResponse<T> {
  Status status;
  T? data;
  String? message;

  DatabaseResponse.initial(this.message) : status = Status.INITIAL;

  DatabaseResponse.hasFavorite(this.data) : status = Status.HAS_FAVORITE;

  DatabaseResponse.hasDefaut(this.data) : status = Status.HAS_DEFAULT;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

// ignore: constant_identifier_names
enum Status { INITIAL, HAS_FAVORITE, HAS_DEFAULT }
