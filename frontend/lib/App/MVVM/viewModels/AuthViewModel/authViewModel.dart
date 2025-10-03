import 'package:flutter/foundation.dart';
import 'package:frontend/App/Core/Responce/api_responce.dart';
import 'package:frontend/App/DataLAYER/repository/authRepo/authRepo.dart';

class AuthViewModel extends ChangeNotifier {
  final _authRepo = AuthRepoo();

  ApiResponce<dynamic> _registrationResponce = ApiResponce.loading();
  ApiResponce<dynamic> get registrationResponce => _registrationResponce;

  ApiResponce<dynamic> _loginResponce = ApiResponce.loading();
  ApiResponce<dynamic> get loginResponce => _loginResponce;

  Future<void> registration(String name, String email, String password) async {
    _registrationResponce = ApiResponce.loading();
    notifyListeners();
    final resp = await _authRepo.register(name, email, password);
    _registrationResponce = resp;
    notifyListeners();
  }

  Future<void> loginUser(String email, String password) async {
    _loginResponce = ApiResponce.loading();
    notifyListeners();
    final resp = await _authRepo.loginUser(email, password);
    _loginResponce = resp;
    notifyListeners();
  }
}



/*
* samjhna   k  lya  ::     

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/auth_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Ordering App',
      home: Scaffold(
        appBar: AppBar(title: const Text("Register")),
        body: Center(
          child: Consumer<AuthViewModel>(
            builder: (context, vm, _) {
              if (vm.registerResponse.status == Status.LOADING) {
                return const CircularProgressIndicator();
              }
              if (vm.registerResponse.status == Status.SUCCESS) {
                return Text("✅ ${vm.registerResponse.data?['message']}");
              }
              if (vm.registerResponse.status == Status.ERROR) {
                return Text("❌ ${vm.registerResponse.message}");
              }
              return ElevatedButton(
                onPressed: () {
                  vm.register("Hami", "hamza@gmail.com", "12345678");
                },
                child: const Text("Register"),
              );
            },
          ),
        ),
      ),
    );
  }
}
*/