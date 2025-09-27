import 'package:frontend/App/exceptions.dart';
import 'package:frontend/App2/Data/Network/Services/auth_services.dart';
import 'package:frontend/App2/Data/Network/interfaces/auth_interfaces.dart';
import 'package:frontend/App2/Data/Responses/api_response.dart';
import 'package:frontend/App2/Resources/app_url.dart';

class AuthRepo {
  final AuthInterfaces _authInterface = AuthServices();

  Future<ApiResponse<Map<String,dynamic>>> registerUser(name, email, password) async {
    try {
      
      final result = await _authInterface.registerUser(
        name,
        email,
        password,
        AppUrl.signup_url,
      );
      final bool isSuccess =(result.containsKey('success') && result['success'] == true
      || result.containsKey('status') && result['status'] == true);

      if (isSuccess) return ApiResponse.success(result); 

      return ApiResponse.error(result['message'] ?? 'Unknown error');
    } on InternetException catch (e) {
      
      print("InternetException ${e.toString()}");
      return ApiResponse.error(e.toString());
    } on RequestTimeOut catch (e) {
      
      print("RequestTimeOut ${e.toString()}");
      return ApiResponse.error(e.toString());
    } on ServerException catch (e) {
      
      print("ServerException ${e.toString()}");
      return ApiResponse.error(e.toString());
    } on FetchDataException catch (e) {
      
      return ApiResponse.error(e.toString());
    } catch (e) {
      
      print("Error ${e.toString()}");
      return ApiResponse.error("Something went wrong: $e");
    }
  }
}
