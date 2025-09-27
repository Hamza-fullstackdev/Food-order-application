import 'package:flutter/foundation.dart';
import 'package:frontend/App2/Data/Responses/api_response.dart';
import 'package:frontend/App2/Repository/auth_repo.dart';

class AuthProvider extends ChangeNotifier {
  final _authRepo = AuthRepo();
  ApiResponse _apiResponse = ApiResponse.NotStarted();

  ApiResponse get apiResponse => _apiResponse;

  Future<void> registerUser(name, email, password, context) async {
    _apiResponse = ApiResponse.loading();
    notifyListeners();
    _apiResponse = await _authRepo.registerUser(name, email, password);
    notifyListeners();
  }
}
