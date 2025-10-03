import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/App/MVVM/views/ProfileScreen.dart';
import 'package:frontend/App/MVVM/views/cart_Screen.dart';
import 'package:frontend/App2/MVVM/Views/homeScreen.dart';
import 'package:frontend/App/MVVM/views/productScreen.dart';

class FoodCourierBottomNav extends StatefulWidget {
  const FoodCourierBottomNav({super.key});
  @override
  State<FoodCourierBottomNav> createState() => _FoodCourierBottomNavState();
}

class _FoodCourierBottomNavState extends State<FoodCourierBottomNav> {
  int _selectedIndex = 0;

  List<Widget> get _screens => [
    ProductScreen(), // now built after providers are available
    ProfileScreen(),
    CartScreen(cartData: []),
    MyHomePage(title: ''),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            icon: FaIcon(FontAwesomeIcons.userSecret),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
        ],
      ),
    );
  }
}
