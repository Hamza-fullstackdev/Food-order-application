// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:frontend/MVVM/ViewModel/address_provider.dart';
import 'package:frontend/MVVM/views/intro_pages.dart';
import 'package:frontend/MVVM/views/login_screen.dart';
import 'package:frontend/Resources/app_routes.dart';
import 'package:frontend/Resources/assetsPath.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lottie/lottie.dart';
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
