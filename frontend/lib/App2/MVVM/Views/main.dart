
import 'package:flutter/material.dart';
import 'package:frontend/App/Widgets/common/bottomNavigation.dart';
import 'package:frontend/App2/MVVM/ViewModel/auth_provider.dart';
import 'package:frontend/App2/MVVM/ViewModel/product_provider.dart';
import 'package:frontend/App2/MVVM/Views/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
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
      home: SplashScreen(),  // pehla kuch code change krna ha  phr push krna ha remeber
    );
  }
}
