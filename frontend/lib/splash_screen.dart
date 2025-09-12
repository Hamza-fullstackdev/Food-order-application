import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:frontend/homeScreen.dart';
import 'package:frontend/intro_page.dart';
import 'package:frontend/utils/app_contants.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
    
    Future.delayed(Duration(seconds: 4),(){
      if(mounted){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => 
           IntroPage()));
      }
    });
    
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      
      decoration: BoxDecoration(
      color: AppContants.whiteColor,
      image: DecorationImage(
        fit: BoxFit.cover,
      image: AssetImage("assets/images/bg_image.png"))
      ),
      child: Center(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: AppContants.whiteColor,
            child: Image.asset("assets/images/bike_image.png"),
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