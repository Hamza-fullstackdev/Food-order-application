import 'package:frontend/App/Core/Exceptions/exceptions.dart';
import 'package:frontend/App2/Data/Network/Services/auth_services.dart';
import 'package:frontend/App2/Data/Network/interfaces/auth_interfaces.dart';
import 'package:frontend/App2/Data/Responses/api_response.dart';
import 'package:frontend/App2/Resources/app_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final AuthInterfaces _authInterface = AuthServices();

  Future<ApiResponse<Map<String, dynamic>>> registerUser(
    String name,
    String email,
    String password,
  ) async {
    try {
      final result = await _authInterface.registerUser(
        name,
        email,
        password,
        AppUrl.signup_url,
      );

      final bool isSuccess =
          (result.containsKey('success') && result['success'] == true) ||
          (result.containsKey('status') &&
              (result['status'] == 200 || result['status'] == 201));

      if (isSuccess) return ApiResponse.success(result);

      return ApiResponse.error(result['message'] ?? 'Unknown error');
    } on InternetException catch (e) {
      return ApiResponse.error(e.toString());
    } on RequestTimeOut catch (e) {
      return ApiResponse.error(e.toString());
    } on ServerException catch (e) {
      return ApiResponse.error(e.toString());
    } on FetchDataException catch (e) {
      return ApiResponse.error(e.toString());
    } catch (e) {
      return ApiResponse.error("Something went wrong: $e");
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> loginUser(String email, String password) async {
    try {
      final result = await _authInterface.loginUser(
        email,
        password,
        AppUrl.login_url,
      );

      final bool isSuccess =
          (result.containsKey('success') && result['success'] == true) ||
          (result.containsKey('status') &&
              (result['status'] == 200 || result['status'] == 201));

      if (isSuccess) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('refreshToken', result['user']['refreshToken']);
        preferences.setString('accessToken', result['user']['accessToken']);
        return ApiResponse.success(result);
      }

      return ApiResponse.error(result['message'] ?? "Unknown Error");
    } on InternetException catch (e) {
      return ApiResponse.error(e.toString());
    } on RequestTimeOut catch (e) {
      return ApiResponse.error(e.toString());
    } on ServerException catch (e) {
      return ApiResponse.error(e.toString());
    } on FetchDataException catch (e) {
      return ApiResponse.error(e.toString());
    } catch (e) {
      return ApiResponse.error("Something went wrong: $e");
    }
  }
}
