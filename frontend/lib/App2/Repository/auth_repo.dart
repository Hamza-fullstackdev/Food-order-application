import 'package:frontend/App/DataLAYER/Service/authService/authService.dart';
import 'package:frontend/App/Core/Exceptions/exceptions.dart';
import 'package:frontend/App2/Data/Responses/api_response.dart';
import 'package:frontend/App2/Resources/app_url.dart';

class AuthRepo {
  final authService = AuthService();
  Future<ApiResponse<Map<String,dynamic>>> register(name, email, password) async {
    
    print("Reached at Auth api resquest Auth repo");
    try {
      final url = AppUrl.signup_url;
      final response = await authService.registerUser(name, email, password, url);
      return ApiResponse.success(response);
    }  on InternetException catch (e) {

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
