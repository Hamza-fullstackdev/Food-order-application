import 'package:flutter/material.dart';
import 'package:frontend/App2/MVVM/Views/splash_screen.dart';
import 'package:frontend/App2/Utils/Routes/route_name.dart';

class Routes {

  static Route<dynamic> generateRoute(RouteSettings setting){
    switch (setting.name){
      case RouteName.SplashPage:
      return MaterialPageRoute(builder: (context) => SplashScreen());
      default:
      return MaterialPageRoute(builder: (_) => Scaffold(
        body: Center(child: Text("No Page Found"),),
      ));
    }
  }
  
}