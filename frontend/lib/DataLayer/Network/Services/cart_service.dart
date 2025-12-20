import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:frontend/DataLayer/Network/Interfaces/cart_interface.dart';
import 'package:frontend/DataLayer/Network/Services/token_validation.dart';
import 'package:frontend/DataLayer/api_exceptions.dart';
import 'package:http/http.dart' as http;

class CartService implements CartInterface {
  @override
  Future<dynamic> addItemToCart(Map<String, dynamic> body, String url) async {
    try {
      final accessToken = await TokenValidation.validateToken();
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decode = jsonDecode(response.body);
        return decode;
      }
      return _handleErrorResponse(response);
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

  @override
  Future<dynamic> getAllCarts(String url) async {
    try {
      final accessToken = await TokenValidation.validateToken();
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decode = jsonDecode(response.body);
        return decode;
      }
      return _handleErrorResponse(response);
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

  @override
  Future<dynamic> removeItemFromCart(
    String url,
  ) async {
    try {
      final accessToken = await TokenValidation.validateToken();
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      final response = await http.delete(
        Uri.parse(url),
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decode = jsonDecode(response.body);
        return decode;
      }
      return _handleErrorResponse(response);
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
  
  @override
  Future<dynamic> updateCart(Map<String, dynamic> body, String url) async {
    try {
      final accessToken = await TokenValidation.validateToken();
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      final response = await http.patch(
        Uri.parse(url),
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decode = jsonDecode(response.body);
        return decode;
      }
      return _handleErrorResponse(response);
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
  
  @override
  Future getSecretKey(String url, Map<String, double> body) async {
   try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(body)
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decode = jsonDecode(response.body);
        return decode;
      }
      return _handleErrorResponse(response);
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
}
