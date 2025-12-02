class ApiException implements Exception {
  final String message;
  final int? code;
  final dynamic cause; 

  ApiException(
    this.message, {
    this.code,
    this.cause,
  });

  @override
  String toString() =>
      "ApiException(code: $code, message: $message, cause: $cause)";
}

class ApiExceptions {
  
  static ApiException noInternet() =>
      ApiException("No internet connection. Please check your network.");

  static ApiException timeout() =>
      ApiException("The request timed out. Please try again.");

  static ApiException serverUnreachable() =>
      ApiException("Server is unreachable at the moment.");

  static ApiException parseError() =>
      ApiException("Failed to process data. Something went wrong.");

  static ApiException unknown([String? msg]) =>
      ApiException(msg ?? "Something went wrong. Please try again.");

 
  static ApiException badRequest([String? details]) =>
      ApiException(_clean("Bad request. $details"), code: 400);

  static ApiException unauthorized([String? msg]) =>
      ApiException(msg ?? "Unauthorized. Please login again.", code: 401);

  static ApiException forbidden([String? msg]) =>
      ApiException(msg ?? "Access denied. You don’t have permission.", code: 403);

  static ApiException notFound([String? msg]) =>
      ApiException(msg ?? "Requested resource not found.", code: 404);

  static ApiException conflict([String? msg]) =>
      ApiException(msg ?? "Conflict error. Please try again.", code: 409);

  static ApiException validationError(String msg) =>
      ApiException("Validation failed: $msg", code: 422);

  static ApiException internalServerError([String? msg]) =>
      ApiException(msg ?? "Internal server error. Please try again later.", code: 500);


  static ApiException fromStatusCode(int code, {String? message}) {
    switch (code) {
      case 400:
        return badRequest(message);
      case 401:
        return unauthorized(message);
      case 403:
        return forbidden(message);
      case 404:
        return notFound(message);
      case 409:
        return conflict(message);
      case 422:
        return validationError(message ?? "Unprocessable data");
      case 500:
        return internalServerError(message);
      default:
        return ApiException(
          message ?? "Unexpected error occurred (code: $code)",
          code: code,
        );
    }
  }

  static String _clean(String input) {
    return input.replaceAll(RegExp(r'\s+'), ' ').trim();
  }
}
