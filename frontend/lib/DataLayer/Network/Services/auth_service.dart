import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:frontend/DataLayer/Network/Interfaces/auth_interfaces.dart';
import 'package:frontend/DataLayer/api_exceptions.dart';
import 'package:http/http.dart' as http;

class AuthService implements AuthInterfaces {
  @override
  Future<dynamic> postResquest(Map<String, dynamic> body, String url) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers["Accept"] = "application/json";

      body.forEach((key, value) {
        request.fields[key] = value.toString();
      });
      final streamResponse = await request.send().timeout(
        Duration(seconds: 20),
      );
      final response = await http.Response.fromStream(streamResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decode = jsonDecode(response.body);

        if (decode is Map<String, dynamic>) {
          return decode;
        } else {
          return {"statusCode": response.statusCode, "body": decode};
        }
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
    switch (response.statusCode) {
      case 400:
        throw ApiExceptions.badRequest("User not found");
      case 401:
        throw ApiExceptions.unauthorized();
      case 403:
        throw ApiExceptions.forbidden();
      case 404:
        throw ApiExceptions.notFound();
      case 409:
        throw ApiExceptions.conflict("User already exists.");
      case 422:
        throw ApiExceptions.validationError("Validation failed.");
      case 500:
        throw ApiExceptions.internalServerError();
      default:
        throw ApiExceptions.unknown("Unexpected error: ${response.statusCode}");
    }
  }

  @override
  Future postRequestForLogin(Map<String, dynamic> body, String url) async {
    try {
      final headers = {'Content-Type': 'application/json'};
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decode = jsonDecode(response.body);

        if (decode is Map<String, dynamic>) {
          return decode;
        } else {
          return {"statusCode": response.statusCode, "body": decode};
        }
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
