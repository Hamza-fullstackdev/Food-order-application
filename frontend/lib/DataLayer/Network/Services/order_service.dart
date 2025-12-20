import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:frontend/DataLayer/Network/Interfaces/order_interface.dart';
import 'package:frontend/DataLayer/Network/Services/token_validation.dart';
import 'package:frontend/DataLayer/api_exceptions.dart';
import 'package:http/http.dart' as http;

class OrderService extends OrderInterface {
  @override
  Future<dynamic> submitOrders(String url) async {
    try {
      final accessToken = await TokenValidation.validateToken();
      final headers = {'Authorization': 'Bearer $accessToken'};

      final response = await http.post(Uri.parse(url), headers: headers).timeout(Duration(seconds: 20));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data;
      }
      _handleErrorResponse(response);
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
  
  @override
  Future<dynamic> getRoutes(String url, String apiKey) async {
     try {
      final headers = {'Authorization':  apiKey};

      final response = await http.get(Uri.parse(url), headers: headers).timeout(Duration(seconds: 20));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data;
      }
      _handleErrorResponse(response);
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
