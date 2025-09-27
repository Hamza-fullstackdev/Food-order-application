import 'package:flutter/foundation.dart';
import 'package:frontend/App2/Data/Responses/api_response.dart';
import 'package:frontend/App2/Data/Responses/status.dart';
import 'package:frontend/App2/Repository/auth_repo.dart';

class AuthProvider extends ChangeNotifier {
  final _authRepo = AuthRepo();
  ApiResponse _apiResponse = ApiResponse.notStarted();

  ApiResponse get apiResponse => _apiResponse;

  Future<bool> registerUser(name, email, password, context) async {
    _apiResponse = ApiResponse.loading();
    notifyListeners();
    _apiResponse = await _authRepo.registerUser(name, email, password);

    if (_apiResponse.status == Status.Success) {
      _apiResponse = ApiResponse.notStarted();
    notifyListeners();

      return true;
    } else {
      _apiResponse = ApiResponse.notStarted();
      notifyListeners();
      return false;
    }
  }
  Future<void> loginUser(email,password,context) async {
    _apiResponse = ApiResponse.loading();
    notifyListeners();
    _apiResponse = await _authRepo.loginUser(email,password);
      notifyListeners();

  }


}
