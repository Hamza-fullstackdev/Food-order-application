import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Resources/assetsPaths/assetsPath.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<Map<String, dynamic>> cartItems = [
    {
      "title": "Chicken Burger",
      "subtitle": "Burger Factory LTD",
      "price": "\$20",
      "image": AssetsPath.burgerPic,
      "qty": 1,
    },
    {
      "title": "Onion Pizza",
      "subtitle": "Pizza Palace",
      "price": "\$15",
      "image": AssetsPath.burgerDetailPic,
      "qty": 1,
    },
    {
      "title": "Spicy Shawarma",
      "subtitle": "Hot Cool Spot",
      "price": "\$15",
      "image": AssetsPath.burgerPic,
      "qty": 1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 24,
            left: -50,
            right: -100,
            child: Image.asset(
              AssetsPath.mealMenuTopPattren,
              height: 220,
              width: MediaQuery.of(context).size.width + 150,
              fit: BoxFit.contain,
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
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
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            CupertinoIcons.back,
                            color: Color(0xffD61355),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Order details",
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Expanded(
                    child: ListView.separated(
                      itemCount: cartItems.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    item["image"],
                                    height: 70,
                                    width: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 15),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item["title"],
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        item["subtitle"],
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        item["price"],
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: const Color(0xffD61355),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.grey.withOpacity(.15),
                                      ),
                                      child: const Icon(
                                        Icons.remove,
                                        size: 18,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      "${item["qty"]}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: const Color(0xffD61355),
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xffDA114D),
                          Color(0xffEE0822),
                          Color(0xffF8131E),
                        ],
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    AssetsPath.cardBackGroundpic,
                                  ),
                                  fit: BoxFit.cover,
                                  opacity: 0.34,
                                ),
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Sub-Total",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "100 \$",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 4),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Delivery Charge",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "10 \$",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 4),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Discount",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "10 \$",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 13),

                              Container(
                                height: 1,
                                color: Colors.white.withOpacity(0.5),
                              ),
                              SizedBox(height: 10),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total",
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "110\$",
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 20),

                              ElevatedButton(
                                onPressed: () {
                                  print("Order Placed!");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Color(0xffD61355),
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 2,
                                ),
                                child: Text(
                                  "Place My Order",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffD61355),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(15),
                  //     gradient: const LinearGradient(
                  //       colors: [Color(0xffDA114D), Color(0xffEE0822)],
                  //       begin: Alignment.topLeft,
                  //       end: Alignment.bottomRight,
                  //     ),
                  //   ),
                  //   child: Stack(
                  //     children: [
                  //       // Background pattern
                  //       Positioned(
                  //         top: 0,
                  //         right: 0,
                  //         bottom: 0,
                  //         child: ClipRRect(
                  //           borderRadius: const BorderRadius.only(
                  //             topRight: Radius.circular(15),
                  //             bottomRight: Radius.circular(15),
                  //           ),
                  //           child: Image.asset(
                  //             AssetsPath.cardBackGroundpic,
                  //             fit: BoxFit.contain,
                  //             height: 100,
                  //           ),
                  //         ),
                  //       ),

                  //       // Content
                  //       Padding(
                  //         padding: const EdgeInsets.all(20.0),
                  //         child: Column(
                  //           children: [
                  //             // Sub-Total
                  //             Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Text(
                  //                   "Sub-Total",
                  //                   style: GoogleFonts.poppins(
                  //                     fontSize: 14,
                  //                     color: Colors.white,
                  //                   ),
                  //                 ),
                  //                 Text(
                  //                   "100 \$",
                  //                   style: GoogleFonts.poppins(
                  //                     fontSize: 14,
                  //                     color: Colors.white,
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //             const SizedBox(height: 8),

                  //             // Delivery Charge
                  //             Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Text(
                  //                   "Delivery Charge",
                  //                   style: GoogleFonts.poppins(
                  //                     fontSize: 14,
                  //                     color: Colors.white,
                  //                   ),
                  //                 ),
                  //                 Text(
                  //                   "10 \$",
                  //                   style: GoogleFonts.poppins(
                  //                     fontSize: 14,
                  //                     color: Colors.white,
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //             const SizedBox(height: 8),

                  //             // Discount
                  //             Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Text(
                  //                   "Discount",
                  //                   style: GoogleFonts.poppins(
                  //                     fontSize: 14,
                  //                     color: Colors.white,
                  //                   ),
                  //                 ),
                  //                 Text(
                  //                   "10 \$",
                  //                   style: GoogleFonts.poppins(
                  //                     fontSize: 14,
                  //                     color: Colors.white,
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),

                  //             const Padding(
                  //               padding: EdgeInsets.symmetric(vertical: 12.0),
                  //               child: Divider(
                  //                 color: Colors.white54,
                  //                 thickness: 1,
                  //               ),
                  //             ),

                  //             // Total
                  //             Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Text(
                  //                   "Total",
                  //                   style: GoogleFonts.poppins(
                  //                     fontSize: 18,
                  //                     fontWeight: FontWeight.w600,
                  //                     color: Colors.white,
                  //                   ),
                  //                 ),
                  //                 Text(
                  //                   "110\$",
                  //                   style: GoogleFonts.poppins(
                  //                     fontSize: 18,
                  //                     fontWeight: FontWeight.bold,
                  //                     color: Colors.white,
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),

                  //             const SizedBox(height: 20),

                  //             // Place Order Button
                  //             SizedBox(
                  //               width: double.infinity,
                  //               height: 50,
                  //               child: ElevatedButton(
                  //                 style: ElevatedButton.styleFrom(
                  //                   backgroundColor: Colors.white,
                  //                   shape: RoundedRectangleBorder(
                  //                     borderRadius: BorderRadius.circular(10),
                  //                   ),
                  //                   elevation: 0,
                  //                 ),
                  //                 onPressed: () {},
                  //                 child: Text(
                  //                   "Place My Order",
                  //                   style: GoogleFonts.poppins(
                  //                     fontSize: 16,
                  //                     color: const Color(0xffD61355),
                  //                     fontWeight: FontWeight.w600,
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:frontend/Resources/assetsPaths/assetsPath.dart';
// import 'package:google_fonts/google_fonts.dart';

// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});

//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   final List<Map<String, dynamic>> cartItems = [
//     {
//       "title": "Chicken Burger",
//       "subtitle": "Burger Factory LTD",
//       "price": "\$20",
//       "image": AssetsPath.burgerPic,
//       "qty": 1,
//     },
//     {
//       "title": "Chicken Burger",
//       "subtitle": "Burger Factory LTD",
//       "price": "\$20",
//       "image": AssetsPath.burgerPic,
//       "qty": 1,
//     },
//     {
//       "title": "Chicken Burger",
//       "subtitle": "Burger Factory LTD",
//       "price": "\$20",
//       "image": AssetsPath.burgerPic,
//       "qty": 1,
//     },
//     {
//       "title": "Onion Pizza",
//       "subtitle": "Pizza Palace",
//       "price": "\$15",
//       "image": AssetsPath.burgerDetailPic,
//       "qty": 1,
//     },
//     {
//       "title": "Spicy Shawarma",
//       "subtitle": "Hot Cool Spot",
//       "price": "\$15",
//       "image": AssetsPath.burgerPic,
//       "qty": 1,
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF8F8FE),
//       body: Stack(
//         children: [
//           // Top background pattern
//           Positioned(
//             top: -100,
//             left: -50,
//             right: -100,
//             child: Image.asset(
//               AssetsPath.mealMenuTopPattren,
//               height: 300,
//               width: MediaQuery.of(context).size.width + 150,
//               fit: BoxFit.cover,
//             ),
//           ),

//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(25.0),
//               child: Column(
//                 children: [
//                   const SizedBox(height: 10),

//                   // Back button
//                   Row(
//                     children: [
//                       Container(
//                         height: 40,
//                         width: 40,
//                         decoration: BoxDecoration(
//                           color: const Color(0xffFFE5E5),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: IconButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           icon: const Icon(
//                             CupertinoIcons.back,
//                             color: Color(0xffD61355),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   // Order Summary Card

//                   const SizedBox(height: 25),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
