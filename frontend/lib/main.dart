import 'package:flutter/material.dart';
import 'package:frontend/MVVM/ViewModel/cart_provider.dart';
import 'package:frontend/MVVM/ViewModel/payment_provider.dart';
import 'package:frontend/MVVM/ViewModel/product_detail_provider.dart';
import 'package:frontend/MVVM/views/add_address_page.dart';
import 'package:frontend/MVVM/views/add_card_page.dart';
import 'package:frontend/MVVM/views/call_screen.dart';
import 'package:frontend/MVVM/views/cart_Screen.dart';
import 'package:frontend/MVVM/views/chat_screen.dart';
import 'package:frontend/MVVM/views/forget_password.dart';
import 'package:frontend/MVVM/views/login_screen.dart';
import 'package:frontend/MVVM/views/payment_page.dart';
import 'package:frontend/MVVM/views/payment_success.dart';
import 'package:frontend/MVVM/views/productDetailscreen.dart';
import 'package:frontend/MVVM/views/productScreen.dart';
import 'package:frontend/MVVM/views/signup_screen.dart';
import 'package:frontend/MVVM/views/splash_page.dart';
import 'package:frontend/MVVM/views/track_order.dart';
import 'package:frontend/MVVM/views/verification_page.dart';
import 'package:frontend/Resources/app_routes.dart';
import 'package:frontend/Widgets/bottomNavigation.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartsProvider()),
        ChangeNotifierProvider(create: (context) => ProductDetailProvider()),
        ChangeNotifierProvider(create: (context) => PaymentMethodsProvider()),
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
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.loginPage,
      routes: {
        AppRoutes.splashPage: (context) => SplashScreen(),
        AppRoutes.loginPage: (context) => LoginScreen(),
        AppRoutes.signupPage: (context) => SignupScreen(),
        AppRoutes.forgetPassword: (context) => ForgetPasswordPage(),
        AppRoutes.verificationPage: (context) => VerifyCode(),
        AppRoutes.productPage: (context) => ProductScreen(),
        AppRoutes.productDetailPage: (context) => ProductDetailPage(),
        AppRoutes.cartPage: (context) => CartPage(),
        AppRoutes.paymentPage: (context) => PaymentPage(),
        AppRoutes.addAddressPage: (context) => AddressesPage(),
        AppRoutes.addCardPage: (context) => AddCard(),
        AppRoutes.paymentSuccess: (context) => PaymentSuccess(),
        AppRoutes.trackOrder: (context) => TrackOrder(),
        AppRoutes.chatScreen: (context) => ChatScreen(),
        AppRoutes.callScreen: (context) => CallScreen(),
        AppRoutes.bottomSheet:(context) => FoodCourierBottomNav()
      },
    );
  }
}
