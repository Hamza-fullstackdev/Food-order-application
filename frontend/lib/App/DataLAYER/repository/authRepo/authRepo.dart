import 'package:frontend/App/DataLAYER/Service/authService/refreshToke.dart';
import 'package:frontend/App/MVVM/models/userLoginModel.dart';
import 'package:frontend/App/Core/Responce/api_responce.dart';
import 'package:frontend/App/DataLAYER/Service/authService/authService.dart';
import 'package:frontend/App/Core/Exceptions/exceptions.dart';
import 'package:frontend/App2/Resources/app_url.dart';

class AuthRepoo {
  AuthRepoo._private();
  static AuthRepoo instance = AuthRepoo._private();
  factory AuthRepoo() {
    return instance;
  }

  final _authService = AuthService();

  Future<ApiResponce<Map<String, dynamic>>> register(
    String name,
    email,
    password,
  ) async {
    final url = AppUrl.signup_url;
    try {
      final responce = await _authService.registerUser(
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

      final loginResponce = await _authService.loginUser(email, password, url);

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


   Future<ApiResponce<String?>> getValidAccessToken() async {
    try {
      final token = await  ToKenService().getValidAccessToken();
      return ApiResponce.success(token);
    } on InternetException catch (e) {
      return ApiResponce.error(e.toString());
    } on RequestTimeOut catch (e) {
      return ApiResponce.error(e.toString());
    } on ServerException catch (e) {
      return ApiResponce.error(e.toString());
    } on FetchDataException catch (e) {
      return ApiResponce.error(e.toString());
    } catch (e) {
      return ApiResponce.error("Unexpected error: $e");
    }
  }

}
