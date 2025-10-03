import 'dart:convert';

import 'package:frontend/App/Core/Exceptions/exceptions.dart';
import 'package:frontend/App2/Resources/app_url.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToKenService {

  ToKenService._();
  static final ToKenService _instance  = ToKenService._();

  factory  ToKenService()
  {

    return _instance  ; 
  }

  Future<String?> _refreshAccessToken(String refreshToken) async {
    try {
      final response = await http.post(
        Uri.parse(AppUrl.refresh_url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $refreshToken",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final newAccessToken = data["user"]["accessToken"];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("accessToken", newAccessToken);

        return newAccessToken;
      } else {
        throw ServerException("Refresh failed: ${response.statusCode}");
      }
    } catch (e) {
      throw FetchDataException("Error refreshing token: $e");
    }
  }

  Future<String?> getValidAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString("accessToken");
    String? refreshToken = prefs.getString("refreshToken");

    if (accessToken == null || refreshToken == null) {
      throw FetchDataException("No tokens found, please login again.");
    }

    bool isExpired = JwtDecoder.isExpired(accessToken);

    if (!isExpired) {
      return accessToken;
    } else {
      return await _refreshAccessToken(refreshToken);
    }
  }
}
