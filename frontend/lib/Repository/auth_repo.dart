import 'package:frontend/DataLayer/Network/Interfaces/auth_interfaces.dart';
import 'package:frontend/DataLayer/Network/Services/auth_service.dart';
import 'package:frontend/DataLayer/Response/api_responces.dart';
import 'package:frontend/DataLayer/api_exceptions.dart';
import 'package:frontend/Resources/app_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final AuthInterfaces _authInterfaces = AuthService();

  Future<ApiResponces<Map<String, dynamic>>> loginUser(
    String email,
    String pass,
  ) async {
    try {
      final url = ApiUrl.loginUrl;

      final body = {"email": email, "password": pass};
      final Map<String, dynamic> data = await _authInterfaces
          .postRequestForLogin(body, url);
      if (data.containsKey('user')) {

        final preference = await SharedPreferences.getInstance();
        final String accessToken = data['user']['accessToken'];
        final String refreshToken = data['user']['refreshToken'];

        preference.setString('accessToken', accessToken);
        preference.setString('refreshToken', refreshToken);
      }

      return ApiResponces.success(data);
    } catch (e) {
      if (e is ApiException) {
        return ApiResponces.failed(e.message);
      }
      return ApiResponces.failed("Unexpected error: ${e.toString()}");
    }
  }

  Future<ApiResponces<Map<String, dynamic>>> signUpUser(
    String name,
    String email,
    String pass,
  ) async {
    try {
      final body = {'name': name, 'email': email, 'password': pass};
      final url = ApiUrl.registerUrl;
      final data = await _authInterfaces.postResquest(body, url);
      return ApiResponces.success(data);
    } catch (e) {
      if (e is ApiException) {

        return ApiResponces.failed(e.message);
      }
      return ApiResponces.failed("Unexpected error: ${e.toString()}");
    }
  }
}
