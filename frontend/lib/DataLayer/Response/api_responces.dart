import 'package:frontend/Resources/status.dart';

class ApiResponces<T> {
  T? data;
  String? message;
  ResponseStatus? status;

  ApiResponces({this.data, this.message, this.status});

  ApiResponces.loading() : status = ResponseStatus.loading;
  ApiResponces.success(this.data) : status = ResponseStatus.success;
  ApiResponces.error(this.message) : status = ResponseStatus.failed;

  @override
  String toString() {
    return 'Status: $status \nData: $data \nMessage: $message';
  }
}
