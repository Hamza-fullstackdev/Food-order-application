// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:frontend/ProfileScreen.dart';
// import 'package:frontend/cart_Screen.dart';
// import 'package:frontend/productScreen.dart';

// class FoodCurierBottomNavBar extends StatefulWidget {
//   const FoodCurierBottomNavBar({super.key});
//   @override
//   State<FoodCurierBottomNavBar> createState() => _FoodCurierBottomNavBarState();
// }

// class _FoodCurierBottomNavBarState extends State<FoodCurierBottomNavBar> {
//   final int _selectedIndex = 0;
//   final List<Widget> _screens = [
//     ProductScreen(),
//     ProfileScreen(),
//     CartScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         bottomNavigationBar: BottomNavigationBar(
//           items: [
//             BottomNavigationBarItem(
//               icon: Icon(CupertinoIcons.house),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(CupertinoIcons.house),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(CupertinoIcons.house),
//               label: 'Home',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//!  Simple structure:
// Ek integer currentIndex (kaunsa tab selected hai)
// Ek list of pages (Home, Search, Profile)
// Tap hone par currentIndex change hota hai, aur wo page dikhata hai.

// Simple Bottom Navigation does'nt follow the Stack Concept, In it only one screen remians in
// the memory that is visible, remaining screens only sawap with previous Screen

import 'package:flutter/material.dart';
import 'package:frontend/App/MVVM/views/ProfileScreen.dart';
import 'package:frontend/App/MVVM/views/cart_Screen.dart';
import 'package:frontend/homeScreen.dart';
import 'package:frontend/App/MVVM/views/productScreen.dart';

class SimpleNavigationExample extends StatefulWidget {
  const SimpleNavigationExample({super.key});
  @override
  State<SimpleNavigationExample> createState() =>
      _SimpleNavigationExampleState();
}

class _SimpleNavigationExampleState extends State<SimpleNavigationExample> {
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
            });
          }
        },

        child: Scaffold(
          body: _screens[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_rounded),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Cart',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//!  2️⃣ Problem – Simple method me kya hota hai?
/* Jab tum ek tab se dusre tab pe jaate ho, purani screen dispose ho jaati hai (state reset ho jaata hai).
Example: Search tab me scroll karke neeche gaye → Home pe gaye → wapas Search pe aaye → scroll position reset
//! Solution:
Iske liye hum IndexedStack use karte hain:
Ye saare pages memory me rakhta hai, bas active page ko show karta hai
IndexedStack keeps all children in the tree (not disposed), only shows
 the child at index. Use it for preserving state, but be mindful: all children stay in memory.
 */
