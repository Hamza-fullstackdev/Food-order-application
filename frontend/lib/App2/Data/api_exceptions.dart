import 'package:frontend/App/Core/Exceptions/exceptions.dart';

class AppException implements Exception{
  final String? message;
  final String? prefix;
  AppException([this.message,this.prefix]);
}



class InternetException extends AppExceptions {
  InternetException([String? message]) : super(message, 'No interet');
}

class RequestTimeOut extends AppExceptions {
  RequestTimeOut([String? message]) : super(message, 'Request time out');
}

class ServerException extends AppExceptions {
  ServerException([String? message]) : super(message, 'Internal server error');
}

class InvalidUrlException extends AppExceptions {
  InvalidUrlException([String? message]) : super(message, 'Invalid Url');
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message]) : super(message, '');
}
