import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/App/MVVM/views/ProfileScreen.dart';
import 'package:frontend/App/MVVM/views/cart_Screen.dart';
import 'package:frontend/homeScreen.dart';
import 'package:frontend/App/MVVM/views/productScreen.dart';

class FoodCourierBottomNav extends StatefulWidget {
  const FoodCourierBottomNav({super.key});
  @override
  State<FoodCourierBottomNav> createState() => _FoodCourierBottomNavState();
}

class _FoodCourierBottomNavState extends State<FoodCourierBottomNav> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    ProductScreen(), // index 0 -> Home
    ProfileScreen(), // index 1 -> Profile
    MyHomePage(title: ''), // index 2 -> Chat
    CartScreen(), // index 3 -> Cart
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Navigation App',
      theme: ThemeData(useMaterial3: true),
      home: PopScope(
        canPop: _selectedIndex == 0,
        // canPop: false,
        onPopInvokedWithResult: (didpop, result) async {
          if (!didpop && _selectedIndex != 0) {
            setState(() {
              _selectedIndex = 0;
              // this is help full 
              
            });
          }
        },

        child: Scaffold(
          body: _screens[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            selectedItemColor: Color(0xffD61355),
            unselectedItemColor: Color(0xffFF8080),
            backgroundColor: Colors.white,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.house_fill),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Chat',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Cart'),
            ],
          ),
        ),
      ),
    );
  }
}
