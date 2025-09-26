import 'dart:convert';
import 'dart:io';

import 'package:frontend/App/MVVM/models/userLoginModel.dart';
import 'package:frontend/App/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  AuthService._privateConstructor();
  static AuthService instance = AuthService._privateConstructor();
  factory AuthService() {
    return instance;
  }

  Future<Map<String, dynamic>> registerUser(
    String name,
    String email,
    String password,
    String url,
  ) async {
    try {
      final registrationUrl = Uri.parse(url);
      final postData = http.MultipartRequest('POST', registrationUrl);

      
      postData.fields['name'] = name;
      postData.fields['email'] = email;
      postData.fields['password'] = password;

      final streamRequest = await postData.send().timeout(
        const Duration(seconds: 10),
      );
      var responce = await http.Response.fromStream(streamRequest);
      if (responce.statusCode == 200 || responce.statusCode == 201) {
        final decode = jsonDecode(responce.body);
        return decode is Map<String, dynamic>
            ? decode
            : {"statusCode": responce.statusCode, "body": decode};
      } else {
        throw ServerException(' Status Code:${responce.statusCode}');
      }
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } catch (e) {
      throw FetchDataException("Unexpected error: $e");
    }
  }

  Future<UserLoginModel> loginUser(
    String email,
    String password,
    String url,
  ) async {
    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"email": email, "password": password}),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final loginModel = UserLoginModel.fromJson(data);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
          "accessToken",
          loginModel.user?.accessToken ?? "",
        );
        await prefs.setString(
          "refreshToken",
          loginModel.user?.refreshToken ?? "",
        );

        return loginModel;
      } else {
        throw ServerException("Login failed: ${response.statusCode}");
      }
    } on SocketException {
      throw InternetException("");
    } on RequestTimeOut {
      throw RequestTimeOut("");
    } catch (e) {
      throw FetchDataException("Unexpected error: $e");
    }
  }
}
