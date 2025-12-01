import 'package:flutter/cupertino.dart';
import 'package:frontend/DataLayer/Response/api_responces.dart';
import 'package:frontend/Repository/auth_repo.dart';
class AuthProvider extends ChangeNotifier {
  final AuthRepo _authInterfaces = AuthRepo();

  ApiResponces _loginResponse = ApiResponces();
  ApiResponces _signUpResponse = ApiResponces();

  ApiResponces get loginResponse => _loginResponse;
  ApiResponces get signUpResponse => _signUpResponse;

  Future<void> loginUser(
    String email,
    String pass,
  ) async {
    _loginResponse = ApiResponces.loading();
    notifyListeners();
    final response = await _authInterfaces.loginUser(email, pass);
    _loginResponse = response;
    notifyListeners();
  }
  Future<void> signUpUser(
    String name,
    String email,
    String pass,
  ) async {
    _signUpResponse = ApiResponces.loading();
    notifyListeners();
    final response = await _authInterfaces.signUpUser(name,email, pass);
    _signUpResponse = response;
    notifyListeners();
  }
}
