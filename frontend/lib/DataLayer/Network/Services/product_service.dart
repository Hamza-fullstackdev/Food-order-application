import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:frontend/DataLayer/Network/Interfaces/product_interface.dart';
import 'package:frontend/DataLayer/Network/Services/token_validation.dart';
import 'package:frontend/DataLayer/api_exceptions.dart';
import 'package:http/http.dart' as http;

class ProductService implements ProductInterface {
  @override
  Future getProductsByCategoryId(String url) async {
    try {
      final String accessToken = await TokenValidation.validateToken();

      final headers = {
        'Authorization': 'Bearer $accessToken',
        'Accept': 'application/json',
      };

      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 20));

      return _handleSuccessOrError(response);
    } on SocketException {
      throw ApiExceptions.noInternet();
    } on TimeoutException {
      throw ApiExceptions.timeout();
    } on FormatException {
      throw ApiExceptions.parseError();
    } catch (e) {
      throw ApiExceptions.unknown(e.toString());
    }
  }

  dynamic _handleSuccessOrError(http.Response response) {
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return decoded;
    }

    return _handleErrorResponse(response);
  }

  dynamic _handleErrorResponse(http.Response response) {
    final message = _extractMessage(response.body);

    switch (response.statusCode) {
      case 400:
        throw ApiExceptions.badRequest(message);
      case 401:
        throw ApiExceptions.unauthorized(message);
      case 403:
        throw ApiExceptions.forbidden(message);
      case 404:
        throw ApiExceptions.notFound(message);
      case 409:
        throw ApiExceptions.conflict(message);
      case 422:
        throw ApiExceptions.validationError(message);
      case 500:
        throw ApiExceptions.internalServerError(message);
      default:
        throw ApiExceptions.unknown(
          "Unexpected error ${response.statusCode}: $message",
        );
    }
  }

  String _extractMessage(String body) {
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map && decoded["message"] != null) {
        return decoded["message"].toString();
      }
      return body;
    } catch (_) {
      return body;
    }
  }
}
