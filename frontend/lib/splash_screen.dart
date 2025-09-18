import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Resources/assetsPaths/assetsPath.dart';
import 'package:frontend/homeScreen.dart';
import 'package:frontend/intro_page.dart';
import 'package:frontend/utils/app_contants.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
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
    _token = pref.getString("Access_Token");
      if(!mounted){return ;} 
        if(_token == null || JwtDecoder.isExpired(_token!)){
        // Navigator.push(context, MaterialPageRoute(builder: (context) => IntroPage()));
        }else {
         Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: "Hello world")));
      }
      
    });
    
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      
      decoration: BoxDecoration(
      color: AppContants.whiteColor,
      ),
      child: Center(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: AppContants.whiteColor,
            child: Image.asset(AssetsPath.bikeImage,height: MediaQuery.of(context).size.height * 0.30,width: MediaQuery.of(context).size.width * 0.30,)
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DefaultTextStyle(style: TextStyle(fontSize: 48,color: AppContants.redColor,fontWeight: FontWeight.bold), child: 
              AnimatedTextKit(animatedTexts: [
                TyperAnimatedText("Food Couriers"),
              ]),),
            )
          ],
        ),
      ),
    );
  }
}