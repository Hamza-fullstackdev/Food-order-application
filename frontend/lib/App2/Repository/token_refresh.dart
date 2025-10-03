import 'dart:convert';

import 'package:frontend/App2/Resources/app_url.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class TokenRefresh {
  
  static String ? accessToken ;
  
  static String ? refreshToken ;
  static dynamic tokenResponse;
  static dynamic otherResponse;

static Future<dynamic> checkToken(String url, {Map<String, dynamic>? body}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  refreshToken = pref.getString("refreshToken");
  accessToken = pref.getString("accessToken");
      // print("$accessToken");

  
  if (JwtDecoder.isExpired(accessToken!)) {
    
  // print("Refresh Token: $refreshToken" );
    final tokenResponse = await http.post(
      Uri.parse(AppUrl.refresh_url),
      headers: {"Content-Type": "application/json","Authorization": "Bearer $refreshToken"},
    );

    if (tokenResponse.statusCode == 200) {
      final data = jsonDecode(tokenResponse.body);
      accessToken = data["user"]["accessToken"];
      refreshToken = data["user"]["refreshToken"];
      

      await pref.setString("accessToken", accessToken!);
      await pref.setString("refreshToken", refreshToken!);
    } else {
      // print("Status code is : ${tokenResponse.statusCode} Token refresh failed: ${tokenResponse.body}");
      return null;
    }
  }

  return hitActualApi(url, {
    "Content-Type": "application/json",
    "Authorization": "Bearer $accessToken"
  });
}
  static dynamic hitActualApi(url , myHeader,{Map<String,dynamic>? body}) async {
    try {
      
      otherResponse = await http.get(Uri.parse(url),
      headers: myHeader);

      if (otherResponse.statusCode == 200 || otherResponse.statusCode == 201) {
        final data = jsonDecode(otherResponse.body);
        
        // print("${otherResponse.statusCode} with data is $data");
        return data;
      }else {
        print(otherResponse.statusCode);
        return null;
      }

    } catch (e) {
      print(e.toString());
    }
  }
}