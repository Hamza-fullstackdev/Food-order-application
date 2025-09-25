import 'package:frontend/App/MVVM/models/userLoginModel.dart';
import 'package:frontend/App/Responce/api_responce.dart';
import 'package:frontend/App/Service/authService/authService.dart';
import 'package:frontend/App/exceptions.dart';
import 'package:frontend/Repos/app_url.dart';

class AuthRepoo {
  AuthRepoo._private();
  static AuthRepoo instance = AuthRepoo._private();
  factory AuthRepoo() {
    return instance;
  }

  final authService = AuthService();

  Future<ApiResponce<Map<String, dynamic>>> register(
    String name,
    email,
    password,
  ) async {
    final url = AppUrl.signup_url;
    try {
      final responce = await authService.registerUser(
        name,
        email,
        password,
        url,
      );
      return ApiResponce.success(responce);
    } on InternetException catch (e) {
      return ApiResponce.error(e.toString());
    } on RequestTimeOut catch (e) {
      return ApiResponce.error(e.toString());
    } on ServerException catch (e) {
      return ApiResponce.error(e.toString());
    } on FetchDataException catch (e) {
      return ApiResponce.error(e.toString());
    } catch (e) {
      return ApiResponce.error("Something went wrong: $e");
    }
  }

  Future<ApiResponce<UserLoginModel>> loginUser(
    String email,
    String password,
  ) async {
    try {
      final url = AppUrl.login_url;

      final loginResponce = await authService.loginUser(email, password, url);

      return ApiResponce.success(loginResponce);
    } on InternetException catch (e) {
      return ApiResponce.error(e.toString());
    } on RequestTimeOut catch (e) {
      return ApiResponce.error(e.toString());
    } on ServerException catch (e) {
      return ApiResponce.error(e.toString());
    } on FetchDataException catch (e) {
      return ApiResponce.error(e.toString());
    } catch (e) {
      return ApiResponce.error("Something went wrong: $e");
    }
  }
}
