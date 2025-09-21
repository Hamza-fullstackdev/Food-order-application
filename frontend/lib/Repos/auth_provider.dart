import 'dart:convert';
import 'package:frontend/Repos/app_url.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  Future<bool> loginUser(email, pass, isLogin,{String ? userName} ) async {
    try {
      late final http.Response response;      
      final url = isLogin ? AppUrl.login_url : AppUrl.signup_url;
    
      final body = isLogin ? {"email": email, "password": pass} :
       {"name" : userName,"email": email, "password": pass};

      final header = {"Content-Type": "application/json"};
      
      response = await http.post(Uri.parse(url),
      headers: header,
      body: jsonEncode(body));

      if(response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data["user"] != null && data["user"]["refreshToken"] != null) {
          SharedPreferences pref = await SharedPreferences.getInstance();
          String refreshToken = data["user"]["refreshToken"];
          String accessToken = data["user"]["accessToken"];
          
          await pref.setString("refreshToken", refreshToken);
          
          await pref.setString("accessToken", accessToken);
          
        }

        
        print(response.body);
        return true;

      }else {
        
        print("Login Failed");
        print(response.body);
        return false;

      }
    } catch (e) {
      
        print("Login Failed");
        print(e.toString());
        return false;
        }
  }
}
