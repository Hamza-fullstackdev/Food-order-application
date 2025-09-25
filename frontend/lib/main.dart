
import 'package:flutter/material.dart';
import 'package:frontend/App/Widgets/common/bottomNavigation.dart';
import 'package:frontend/Repos/auth_provider.dart';
import 'package:frontend/Repos/product_provider.dart';
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
      home: FoodCourierBottomNav(),  // pehla kuch code change krna ha  phr push krna ha remeber
    );
  }
}
