import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:frontend/App/exceptions.dart';
import 'package:frontend/App2/Data/Network/interfaces/get_request_interface.dart';
import 'package:frontend/App2/Resources/app_url.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetRequestService implements GetRequestInterface  {
  static String? accessToken;
  static String? refreshToken;
  static dynamic tokenResponse;

  Future<dynamic> getDataRequest(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      refreshToken = pref.getString("refreshToken");
      accessToken = pref.getString("accessToken");
      print(accessToken);

      if (JwtDecoder.isExpired(accessToken!)) {
        final tokenResponse = await http.post(
          Uri.parse(AppUrl.refresh_url),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $refreshToken",
          },
        );

        if (tokenResponse.statusCode == 200) {
          final data = jsonDecode(tokenResponse.body);
          accessToken = data["user"]["accessToken"];
          refreshToken = data["user"]["refreshToken"];

          await pref.setString("accessToken", accessToken!);
          await pref.setString("refreshToken", refreshToken!);
        } else {
          return null;
        }
      }

      return hitActualApi(url, {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      });
    } on SocketException {
      throw InternetException();
    } on TimeoutException {
      throw RequestTimeOut();
    } catch (e) {
      throw FetchDataException(e.toString());
    }
  }

  static dynamic hitActualApi(String url, Map<String, String> myHeader) async {
    try {
     final response = await http.get(Uri.parse(url), headers: myHeader);
      final decoded = jsonDecode(response.body);

      return decoded ;
    } on SocketException {
      throw InternetException();
    } on TimeoutException {

      throw RequestTimeOut();
    } catch (e) {
      throw FetchDataException(e.toString());
    }
  }
}
