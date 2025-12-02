import 'package:flutter/material.dart';
import 'package:frontend/MVVM/views/intro_pages.dart';
import 'package:frontend/Resources/app_routes.dart';
import 'package:frontend/Resources/assetsPath.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState()=> _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  String ? _token;

  @override
  void initState()  {
    super.initState();
    
    Future.delayed(Duration(seconds: 4),() async {
      
    SharedPreferences pref = await SharedPreferences.getInstance();
    _token = pref.getString("refreshToken");
    print(_token);
      if(!mounted){return ;} 
        if(_token == null || JwtDecoder.isExpired(_token!)){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => IntroPage()));
        }else {
         Navigator.popAndPushNamed(context, AppRoutes.bottomSheet);

      }
      
    });
    
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Lottie.asset(
            AnimationPaths.loading2,
            width: 200,
            height: 200,
            repeat: true,
          ),
        ),
      );
  }
}