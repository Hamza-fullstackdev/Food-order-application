import 'package:flutter/material.dart';
import 'package:frontend/App/MVVM/viewModels/ProductViewModel/productViewModel.dart';
import 'package:frontend/App/MVVM/viewModels/cartViewModel/cartViewModel.dart';
import 'package:frontend/App/MVVM/viewModels/categoryViewModel/categoryViewModel.dart';
import 'package:frontend/App/Widgets/common/bottomNavigation.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryViewModel()),

        ChangeNotifierProvider(create: (_) => ProductViewModel()),
                ChangeNotifierProvider(create: (_) => CartProvider()),


        
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
      home: const FoodCourierBottomNav(),
    );
  }
}
