import 'package:frontend/App2/Repository/auth_repo.dart';
import 'package:frontend/App2/Resources/app_url.dart';
import 'package:frontend/App2/Data/Network/Services/auth_api_request.dart';
import 'package:flutter/material.dart';
import 'package:frontend/App2/Data/Responses/api_response.dart';

class AuthProvider extends ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.loading();

  ApiResponse<dynamic> get apiResponse  => _apiResponse; 

  Future<dynamic> registerUser(name,email,password) async {
    print("Reached at register");
    _apiResponse = ApiResponse.loading();
    notifyListeners();
    final body = {"name" : name,"email": email, "password": password};

    _apiResponse = await AuthRepo().register(name, email, password);
    notifyListeners();

    return apiResponse;
  }

Future<dynamic> login(email,password) async {
    _apiResponse = ApiResponse.loading();
    notifyListeners();
    final body = {"email": email, "password": password};
    
    _apiResponse = await AuthApiRequest().postApiServices(AppUrl.login_url,body);
    notifyListeners();
    return apiResponse;
    
  }
 /*
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
*/
}
