import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:frontend/App/MVVM/models/userLoginModel.dart';
import 'package:frontend/App/Core/Exceptions/exceptions.dart';
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
    } on TimeoutException {
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
          //  loginModel.user?.accessToken ??
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGQyOTFhYjYwNjExNjMzNzg2NzlhOTYiLCJpYXQiOjE3NTkyMjU5MjMsImV4cCI6MTc1OTIyNjgyM30._1oSB6qek1DublzU_OmNR1ZME5EmDooN0Zwnmc9l0rc",
        );
        await prefs.setString(
          "refreshToken",
          // loginModel.user?.refreshToken ??
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGQyOTFhYjYwNjExNjMzNzg2NzlhOTYiLCJpYXQiOjE3NTkxNDA5NDEsImV4cCI6MTc1OTc0NTc0MX0.a0_HuQ00HVcU-43ei_1z842rUGR0cJY7pEsJL83uTYM",
        );

        return loginModel;
      } else {
        throw ServerException("Login failed: ${response.statusCode}");
      }
    } on SocketException {
      throw InternetException("");
    } on TimeoutException {
      throw RequestTimeOut("");
    } catch (e) {
      throw FetchDataException("Unexpected error: $e");
    }
  }

  
}
