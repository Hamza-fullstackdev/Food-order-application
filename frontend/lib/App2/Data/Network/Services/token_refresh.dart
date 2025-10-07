import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:frontend/App/Core/Exceptions/exceptions.dart';
import 'package:frontend/App2/Resources/app_url.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenRefresh {
  static String? accessToken;
  static String? refreshToken;
  static dynamic tokenResponse;

  static Future<String> tokenValidation() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      refreshToken = pref.getString("refreshToken");
      accessToken = pref.getString("accessToken");

      if (JwtDecoder.isExpired(accessToken!)) {
        final tokenResponse = await http
            .post(
              Uri.parse(AppUrl.refresh_url),
              headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer $refreshToken",
              },
            )
            .timeout(Duration(seconds: 10));

        if (tokenResponse.statusCode == 200) {
          final data = jsonDecode(tokenResponse.body);
          accessToken = data["user"]["accessToken"];
          refreshToken = data["user"]["refreshToken"];

          await pref.setString("accessToken", accessToken!);
          await pref.setString("refreshToken", refreshToken!);
        }
      }
      return accessToken!;
    } on SocketException {
      throw InternetException();
    } on TimeoutException {
      throw RequestTimeOut();
    } catch (e) {
      throw FetchDataException(e.toString());
    }
  }
}
