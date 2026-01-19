// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/MVVM/views/ProfileScreen.dart';
import 'package:frontend/MVVM/views/cart_Screen.dart';
import 'package:frontend/MVVM/views/chat_screen.dart';
import 'package:frontend/MVVM/views/productScreen.dart';
import 'package:frontend/Resources/app_colors.dart';

class FoodCourierBottomNav extends StatefulWidget {
  const FoodCourierBottomNav({super.key});
  @override
  State<FoodCourierBottomNav> createState() => _FoodCourierBottomNavState();
}

class _FoodCourierBottomNavState extends State<FoodCourierBottomNav> {
  int _selectedIndex = 0;

  List<Widget> get _screens => [
    ProductScreen(),
    CartPage(),
    ChatScreen(),
    ProfilePage(),
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
        selectedItemColor: AppColors.orangeColor,
        unselectedItemColor: AppColors.lightBlackColor,
        backgroundColor: AppColors.lightOrangeColor,

        selectedFontSize: 16,
        unselectedFontSize: 14,
        unselectedIconTheme: const IconThemeData(size: 25),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w900),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),

        selectedIconTheme: const IconThemeData(size: 30),

        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house_fill),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.chat_rounded),
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.userSecret),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
