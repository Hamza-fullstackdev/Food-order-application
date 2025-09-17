import 'dart:convert';
import 'dart:ffi';

import 'package:frontend/Repos/app_url.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<bool> loginUser(email, pass, userName,isLogin ) async {
    try {
      late final http.Response response;

      _isLoading = true;
      
      final url = isLogin ? AppUrl.login_url : AppUrl.signup_url;
      
      final body = isLogin ? {"email": email, "password": pass} :
       {"name" : userName,"email": email, "password": pass};

      final header = {"Content-Type": "application/json"};
      
      response = await http.post(Uri.parse(url),
      headers: header,
      body: jsonEncode(body));

      if(response.statusCode == 200 || response.statusCode == 201) {
        _isLoading = false;
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("tokenId", response.body.toString());
        print(jsonDecode(response.body));
        print("Login success");

        return true;

      }else {
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
