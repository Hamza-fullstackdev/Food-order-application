import 'dart:convert';

import 'package:frontend/Repos/app_url.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class TokenRefresh {
  
  static String ? accessToken ;
  
  static String ? refreshToken ;
  static dynamic tokenResponse;
  static dynamic otherResponse;


 static Future<dynamic> checkToken(
    url,{Map<String,dynamic> ? body}
    ) async {
      try {
        
    SharedPreferences pref = await SharedPreferences.getInstance();
    refreshToken = pref.getString("refreshToken");
    accessToken = pref.getString("accessToken");


    final myHeader = {
          "Content-Type": "application/json",
          "Authorization": "Bearer $refreshToken"
        };
        
    bool isExpired = JwtDecoder.isExpired(accessToken!);
    if(isExpired){
      tokenResponse = await http.post(
        Uri.parse(AppUrl.refresh_url),
        headers: myHeader     
        );
      if (tokenResponse.statusCode == 200) {
        final data = jsonDecode(tokenResponse.body);
        if (data["user"] != null && data["user"]["accessToken"] != null) {
          accessToken = data["user"]["accessToken"];
          refreshToken = data["user"]["refreshToken"];
         return hitActualApi(url,{
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        });
    
        } 
      }else{
          print("Your failed access token is : $accessToken");
      }
    }else{
     return hitActualApi(url,{
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        });
    }


      } catch (e) {
        print(e.toString());
      }
    }
  static dynamic hitActualApi(url , myHeader,{Map<String,dynamic>? body}) async {
    try {
      
      otherResponse = await http.get(Uri.parse(url),
      headers: myHeader);

      if (otherResponse.statusCode == 200 || otherResponse.statusCode == 201) {
        final data = jsonDecode(otherResponse.body);
        
        print(otherResponse.statusCode);
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