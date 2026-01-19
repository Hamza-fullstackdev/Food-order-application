// ignore_for_file: use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:frontend/MVVM/ViewModel/address_provider.dart';
import 'package:frontend/MVVM/views/intro_pages.dart';
import 'package:frontend/MVVM/views/login_screen.dart';
import 'package:frontend/Resources/app_colors.dart';
import 'package:frontend/Resources/app_routes.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  String? _token;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 4), () async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      _token = pref.getString("refreshToken");
      if (!mounted) {
        return;
      }
      if (_token == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => IntroPage()),
        );
        return;
      }

      if (JwtDecoder.isExpired(_token!)) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
        return;
      }
      await Provider.of<AddressProvider>(
        context,
        listen: false,
      ).checkLocationPermission();

      Navigator.popAndPushNamed(context, AppRoutes.bottomSheet);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(left: 100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            BounceInDown(
              duration: const Duration(milliseconds: 1200),
              child: Image.asset(
                'assets/logo/logo.png',
                width: 190,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),

            LoadingAnimationWidget.staggeredDotsWave(
              
              color: AppColors.darkOrangeColor,
              size: 60,
            ),
          ],
        ),
      ),
    );
  }
}
