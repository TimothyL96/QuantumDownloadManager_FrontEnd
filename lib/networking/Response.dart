class Response<T> {
  Status status;
  T? data;
  String? message;

  Response.loading(this.message) : status = Status.LOADING;
  Response.completed(this.data) : status = Status.COMPLETED;
  Response.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status: $status\nMessage: $message\nData: $data";
  }
}

enum Status {
  LOADING,
  COMPLETED,
  ERROR,
}