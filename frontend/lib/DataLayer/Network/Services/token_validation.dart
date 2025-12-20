import 'dart:convert';
import 'package:frontend/DataLayer/api_exceptions.dart';
import 'package:frontend/Resources/app_url.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TokenValidation {
  static Future<String> validateToken() async {
    try {
      final pref = await SharedPreferences.getInstance();

      String? accessToken =  pref.getString('accessToken');
      String? refreshToken =  pref.getString('refreshToken');

      if (accessToken == null || refreshToken == null) {
        throw ApiExceptions.unauthorized();
      }

      if (!JwtDecoder.isExpired(accessToken)) {
        return accessToken;
      }

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $refreshToken',
      };

      final response = await http
          .post(Uri.parse(ApiUrl.refreshTokenUrl), headers: headers)
          .timeout(Duration(seconds: 20));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        accessToken = data['user']?['accessToken'];
        refreshToken = data['user']?['refreshToken'];

        if (accessToken == null || refreshToken == null) {
          throw ApiExceptions.internalServerError();
        }

        await pref.setString('accessToken', accessToken);
        await pref.setString('refreshToken', refreshToken);

        return accessToken;
      } else {
        _handleErrorResponse(response, jsonDecode(response.body)['message']);
      }

      throw ApiExceptions.unknown("Unexpected token refresh behavior");
    } catch (e) {
      if (e is ApiExceptions) rethrow;
      throw ApiExceptions.unknown("Token refresh failed: $e");
    }
  }

  static dynamic _handleErrorResponse(http.Response response, message) {
    switch (response.statusCode) {
      case 400:
        throw ApiExceptions.badRequest(message);
      case 401:
        throw ApiExceptions.unauthorized();
      case 403:
        throw ApiExceptions.forbidden();
      case 404:
        throw ApiExceptions.notFound();
      case 409:
        throw ApiExceptions.conflict(message);
      case 422:
        throw ApiExceptions.validationError(message);
      case 500:
        throw ApiExceptions.internalServerError();
      default:
        throw ApiExceptions.unknown("Unexpected error: ${response.statusCode}");
    }
  }
}
