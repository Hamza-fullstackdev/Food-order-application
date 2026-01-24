import 'package:frontend/Resources/status.dart';

class ApiResponces<T> {
  String? message;
  T? data;
  ResponseStatus? status;

  ApiResponces({this.data,this.message,this.status});

  ApiResponces.loading() : status = ResponseStatus.loading;
  ApiResponces.success(this.data) : status = ResponseStatus.success;
  ApiResponces.failed(this.message) : status = ResponseStatus.failed;

  @override
  String toString(){
    return 'Status: $status\nMessage: $message\nData: $data';
  }
}