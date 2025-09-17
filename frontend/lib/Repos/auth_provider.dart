import 'dart:convert';
import 'package:frontend/Repos/app_url.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isLoggedIn = false;
  
  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;

  Future<bool> loginUser(email, pass, isLogin,{String? userName} ) async {
    try {
      late final response;
      _isLoading = true;

      final url = isLogin ? AppUrl.login_url : AppUrl.signup_url;
      final body = isLogin
          ? {"email": email, "password": pass}
          : {"name": userName, "email": email, "password": pass};
      final header = {"Content-Type": "application/json"};

      response = await http.post(
        Uri.parse(url),
        headers: header,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _isLoading = false;
        final data = jsonDecode(response.body);
        if (data["user"] != null && data["user"]["refreshToken"] != null) {
          SharedPreferences pref = await SharedPreferences.getInstance();
          String token = data["user"]["refreshToken"];
          await pref.setString("Access_Token", token);
        }
        _isLoggedIn = true;
        notifyListeners();
        return true;
      } else {
        _isLoading = false;

        print("Login Failed");
        print(response.body);
        return false;
      }
    } catch (e) {
      _isLoading = false;

      print(e.toString());

      return false;
    }
  }
}
