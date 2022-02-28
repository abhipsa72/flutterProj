import 'package:grand_uae/customer/enums/status.dart';

class ApiResponse<T> {
  Status status = Status.Idle;
  T data;
  String message;

  ApiResponse.idle() : status = Status.Idle;

  ApiResponse.loading(this.message) : status = Status.Loading;

  ApiResponse.completed(this.data) : status = Status.Completed;

  ApiResponse.error(this.message) : status = Status.Error;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}
