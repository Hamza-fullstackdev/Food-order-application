class ApiException implements Exception {
  final String message;
  final int? code;

  ApiException(this.message, {this.code});

  @override
  String toString() => "ApiException(code: $code, message: $message)";
}

class ApiExceptions {
  static ApiException noInternet() =>
      ApiException("No internet connection. Please check your network.");

  static ApiException timeout() =>
      ApiException("The request timed out. Please try again.");

  static ApiException serverUnreachable() =>
      ApiException("Server is not reachable at the moment.");

  static ApiException badRequest(String? details) =>
      ApiException("Bad request. ${details ?? ""}".trim(), code: 400);

  static ApiException unauthorized() =>
      ApiException("Unauthorized request. Please login again.", code: 401);

  static ApiException forbidden() =>
      ApiException("Access denied. You don't have permission.", code: 403);

  static ApiException notFound() =>
      ApiException("Requested resource was not found.", code: 404);

  static ApiException conflict([String? msg]) =>
      ApiException(msg ?? "Conflict error. Please try again.", code: 409);

  static ApiException validationError(String msg) =>
      ApiException("Validation failed: $msg", code: 422);

  static ApiException internalServerError() =>
      ApiException("Internal server error. Please try again later.", code: 500);

  static ApiException parseError() =>
      ApiException("Failed to process data. Something went wrong.");

  static ApiException unknown([String? msg]) =>
      ApiException(msg ?? "Something went wrong. Please try again.");
}
