import 'package:frontend/App2/Data/Responses/app_enums.dart';

class ApiResponse<T> {
  String? message;
  T? data;
  Status? status;

  ApiResponse([this.data, this.message, this.status]);
  ApiResponse.loading() : status = Status.LOADING;
  ApiResponse.success(this.data) : status = Status.SUCCESS;
  ApiResponse.error(this.message) : status = Status.FAILED;

  String toString() {
    return "Status : $status \n Data : $data \n Message : $message";
  }
}
