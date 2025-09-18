// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:frontend/Resources/assetsPaths/assetsPath.dart';
// import 'package:frontend/productDetailscreen.dart';
// import 'package:google_fonts/google_fonts.dart';

// class MealMenuScreen extends StatefulWidget {
//   const MealMenuScreen({super.key});

//   @override
//   State<MealMenuScreen> createState() => _MealMenuScreenState();
// }

// class _MealMenuScreenState extends State<MealMenuScreen> {
//   // backgroundColor: const Color(0xffD61355),   backgroundColor: const Color(0xffFFE5E5),

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffF8F8FE),
//       body: Padding(
//         padding: const EdgeInsets.all(25.0),
//         child: Column(
//           children: [
//             SizedBox(height: 30),
//             Row(
//               children: [
//                 Container(
//                   height: 40,
//                   width: 40,
//                   decoration: BoxDecoration(
//                     color: const Color(0xffFFE5E5),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: IconButton(
//                     onPressed: () {},
//                     icon: Icon(
//                       CupertinoIcons.back,
//                       color: const Color(0xffD61355),
//                     ),
//                   ),
//                 ),
//                 Spacer(),
//                 Stack(
//                   children: [
//                     Container(
//                       height: 40,
//                       width: 40,
//                       decoration: BoxDecoration(
//                         color: const Color(0xffFFE5E5),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: IconButton(
//                         onPressed: () {},
//                         icon: Icon(
//                           CupertinoIcons.bell,
//                           color: const Color(0xffD61355),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       top: 10.4,
//                       right: 13.7,
//                       child: Container(
//                         height: 5.8,
//                         width: 5.8,
//                         decoration: BoxDecoration(
//                           color: Color(0xffD61355),

//                           shape: BoxShape.circle,
//                           border: Border.all(color: Colors.white, width: .7),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),

//             Align(
//               alignment: Alignment.topLeft,
//               child: Text(
//                 'Meal Menu',
//                 style: GoogleFonts.poppins(
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             SizedBox(height: 15),
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 gradient: LinearGradient(
//                   colors: [
//                     Color(0xffE7A6C6).withOpacity(.3),
//                     Color(0xffE7A6C6).withOpacity(.4),
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 35.0),
//                 child: TextField(
//                   cursorColor: Colors.black,
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(
//                       CupertinoIcons.search,
//                       size: 20,
//                       color: Colors.black,
//                     ),
//                     prefixIconConstraints: BoxConstraints(),
//                     hintText: 'Search',
//                     hintStyle: GoogleFonts.poppins(
//                       fontSize: 14,
//                       color: Colors.black54,
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide.none,
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide.none,
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide.none,
//                     ),
//                     contentPadding: EdgeInsets.symmetric(),
//                   ),
//                   style: TextStyle(color: Colors.black),
//                 ),
//               ),
//             ),
//             // SizedBox(height: 20),
//             SizedBox(
//               height: 600,
//               child: ListView.builder(
//                 itemCount: 12,
//                 itemBuilder: (context, index) {
//                   return InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ProductDetailScreen(
//                             imagePath: AssetsPath.burgerPic,
//                           ),
//                         ),
//                       );
//                     },
//                     child: Card(
//                       elevation: .7,
//                       color: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(10),
//                         child: Row(
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(6),
//                               child: Image.asset(
//                                 AssetsPath.burgerDetailPic,
//                                 height: 80,
//                                 width: 80,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             SizedBox(width: 12),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Pepper Pizza",
//                                   style: GoogleFonts.poppins(
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                                 Text(
//                                   "5kg box of Pizza",
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 12,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Spacer(),

//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 "\$15",
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 16,
//                                   color: Color(0xffD61355),
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Resources/assetsPaths/assetsPath.dart';
import 'package:frontend/productDetailscreen.dart';
import 'package:google_fonts/google_fonts.dart';

class MealMenuScreen extends StatefulWidget {
  const MealMenuScreen({super.key});

  @override
  State<MealMenuScreen> createState() => _MealMenuScreenState();
}

class _MealMenuScreenState extends State<MealMenuScreen> {
  final List<Map<String, dynamic>> meals = [
    {
      "title": "Chicken Spagetti",
      "subtitle": "1 Big Pack",
      "price": "\$7",
      "image": AssetsPath.burgerDetailPic,
    },
    {
      "title": "Jollof Rice",
      "subtitle": "1 Combo pack",
      "price": "\$10",
      "image": AssetsPath.burgerPic,
    },
    {
      "title": "Fruity Pancakes",
      "subtitle": "Noodle Home",
      "price": "\$12",
      "image": AssetsPath.burgerDetailPic,
    },
    {
      "title": "Pepper Pizza",
      "subtitle": "5kg box of Pizza",
      "price": "\$15",
      "image": AssetsPath.burgerPic,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F8FE),
      body: Stack(
        children: [
          // 🔹 Top background image
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/images/Group.png",
              height: 120,
              fit: BoxFit.cover,
            ),
          ),

          // Main content
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                const SizedBox(height: 40),

                // 🔹 Top Row (Back + Bell)
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xffFFE5E5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          CupertinoIcons.back,
                          color: Color(0xffD61355),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Stack(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xffFFE5E5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              CupertinoIcons.bell,
                              color: const Color(0xffD61355),
                            ),
                          ),
                        ),

                        Positioned(
                          top: 10.4,
                          right: 13.7,
                          child: Container(
                            height: 5.8,
                            width: 5.8,
                            decoration: BoxDecoration(
                              color: const Color(0xffD61355),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: .7,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // 🔹 Title
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Meal Menu',
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // 🔹 Search Box
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xffE7A6C6).withOpacity(.3),
                        const Color(0xffE7A6C6).withOpacity(.4),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: TextField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        CupertinoIcons.search,
                        size: 20,
                        color: Colors.black,
                      ),
                      hintText: 'Search',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),

                const SizedBox(height: 20),

                // 🔹 Meal List
                Expanded(
                  child: ListView.separated(
                    itemCount: meals.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final meal = meals[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailScreen(imagePath: meal["image"]),
                            ),
                          );
                        },
                        child: Card(
                          elevation: .7,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.asset(
                                    meal["image"],
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      meal["title"],
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      meal["subtitle"],
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    meal["price"],
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: Color(0xffD61355),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
