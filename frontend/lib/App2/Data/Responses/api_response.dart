import 'package:frontend/App2/Data/Responses/status.dart';

class ApiResponse<T> {
  String ? message ;
  T ? data;
  Status? status;

  ApiResponse(this.status,this.data,this.message);

  ApiResponse.loading() : status = Status.Loading;
  ApiResponse.success(this.data) : status = Status.Success;
  ApiResponse.error(this.message) : status = Status.Error;
  
  ApiResponse.notStarted() : status = Status.NotStarted;

  @override
  String toString(){
    return 'Status: $status \nData: $data \n Message: $message';
  }
}