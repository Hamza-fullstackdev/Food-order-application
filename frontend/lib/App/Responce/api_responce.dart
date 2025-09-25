import 'package:frontend/App/status.dart';

class ApiResponce<T> {
  Status? status;
  T? data;
  String? message;

  ApiResponce(this.status, this.data, this.message);
  ApiResponce.loading() : status = Status.LOADING;
  ApiResponce.success(this.data) : status = Status.SUCCESS;
  ApiResponce.error(this.message) : status = Status.ERROR;

 @override
  String toString() {
    return "Status : $status \n Message :  $message \n Data: $data";
  }
}
