import 'package:flutter/material.dart';
import 'package:frontend/App/MVVM/viewModels/cart_view_model.dart';
import 'package:frontend/App2/MVVM/ViewModel/auth_provider.dart';
import 'package:frontend/App2/MVVM/ViewModel/category_view_model.dart';
import 'package:frontend/App2/MVVM/ViewModel/product_detail_view_model.dart';
import 'package:frontend/App2/MVVM/ViewModel/product_provider.dart';
import 'package:frontend/App2/MVVM/Views/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => ProductDetailViewModel()),
        ChangeNotifierProvider(create: (context) => CategoryViewModel()),
        ChangeNotifierProvider(create: (context) => CartViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Curier',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen(),
    );
  }
}
