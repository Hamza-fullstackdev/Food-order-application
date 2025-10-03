// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:frontend/App/MVVM/models/cartModel.dart';
// import 'package:frontend/App/Resources/assetsPaths/assetsPath.dart';
// import 'package:google_fonts/google_fonts.dart';

// class CartScreen extends StatefulWidget {
//   // final List<Map<String, dynamic>>? cartData;
//   // String imageUrl ;
//   // String productName;
//   // String productprice ;
//   // String shortDrtail  ;

//    final List<CartModel>? cartData ;
//    const CartScreen(   this.cartData,  {super.key});
//   // const CartScreen({super.key});

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
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           Positioned(
//             top: 24,
//             left: -50,
//             right: -100,
//             child: Image.asset(
//               AssetsPath.mealMenuTopPattren,
//               height: 220,
//               width: MediaQuery.of(context).size.width + 150,
//               fit: BoxFit.contain,
//             ),
//           ),

//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(25.0),
//               child: Column(
//                 children: [
//                   const SizedBox(height: 10),
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

//                   const SizedBox(height: 25),

//                   Align(
//                     alignment: Alignment.topLeft,
//                     child: Text(
//                       "Order details",
//                       style: GoogleFonts.poppins(
//                         fontSize: 25,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 30),

//                   Expanded(
//                     child: ListView.separated(
//                       itemCount: cartItems.length,
//                       separatorBuilder: (_, __) => const SizedBox(height: 20),
//                       itemBuilder: (context, index) {
//                         final item = cartItems[index];
//                         return Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(12),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.1),
//                                 spreadRadius: 2,
//                                 blurRadius: 6,
//                                 offset: const Offset(0, 2),
//                               ),
//                             ],
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(12.0),
//                             child: Row(
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(8),
//                                   child: Image.asset(
//                                     item["image"],
//                                     height: 70,
//                                     width: 70,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 15),

//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         item["title"],
//                                         style: GoogleFonts.poppins(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 2),
//                                       Text(
//                                         item["subtitle"],
//                                         style: GoogleFonts.poppins(
//                                           fontSize: 12,
//                                           color: Colors.grey,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 8),
//                                       Text(
//                                         item["price"],
//                                         style: GoogleFonts.poppins(
//                                           fontSize: 16,
//                                           color: const Color(0xffD61355),
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),

//                                 Row(
//                                   children: [
//                                     Container(
//                                       height: 30,
//                                       width: 30,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(8),
//                                         color: Colors.grey.withOpacity(.15),
//                                       ),
//                                       child: const Icon(
//                                         Icons.remove,
//                                         size: 18,
//                                         color: Colors.black54,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 12),
//                                     Text(
//                                       "${item["qty"]}",
//                                       style: GoogleFonts.poppins(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 12),
//                                     Container(
//                                       height: 30,
//                                       width: 30,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(8),
//                                         color: const Color(0xffD61355),
//                                       ),
//                                       child: const Icon(
//                                         Icons.add,
//                                         size: 18,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [
//                           Color(0xffDA114D),
//                           Color(0xffEE0822),
//                           Color(0xffF8131E),
//                         ],
//                       ),
//                     ),
//                     child: Stack(
//                       children: [
//                         Positioned.fill(
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(15),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                   image: AssetImage(
//                                     AssetsPath.cardBackGroundpic,
//                                   ),
//                                   fit: BoxFit.cover,
//                                   opacity: 0.34,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),

//                         Padding(
//                           padding: EdgeInsets.all(20),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "Sub-Total",
//                                     style: GoogleFonts.poppins(
//                                       fontSize: 14,
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                   Text(
//                                     "100 \$",
//                                     style: GoogleFonts.poppins(
//                                       fontSize: 14,
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ],
//                               ),

//                               SizedBox(height: 4),

//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "Delivery Charge",
//                                     style: GoogleFonts.poppins(
//                                       fontSize: 14,
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                   Text(
//                                     "10 \$",
//                                     style: GoogleFonts.poppins(
//                                       fontSize: 14,
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ],
//                               ),

//                               SizedBox(height: 4),

//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "Discount",
//                                     style: GoogleFonts.poppins(
//                                       fontSize: 14,
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                   Text(
//                                     "10 \$",
//                                     style: GoogleFonts.poppins(
//                                       fontSize: 14,
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ],
//                               ),

//                               SizedBox(height: 13),

//                               Container(
//                                 height: 1,
//                                 color: Colors.white.withOpacity(0.5),
//                               ),
//                               SizedBox(height: 10),

//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "Total",
//                                     style: GoogleFonts.poppins(
//                                       fontSize: 18,
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Text(
//                                     "110\$",
//                                     style: GoogleFonts.poppins(
//                                       fontSize: 18,
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),

//                               SizedBox(height: 20),

//                               ElevatedButton(
//                                 onPressed: () {
//                                   print("Order Placed!");
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.white,
//                                   foregroundColor: Color(0xffD61355),
//                                   padding: EdgeInsets.symmetric(vertical: 16),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   elevation: 2,
//                                 ),
//                                 child: Text(
//                                   "Place My Order",
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                     color: Color(0xffD61355),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// lib/App/MVVM/views/cart_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/App/MVVM/models/cartModel.dart';
import 'package:frontend/App/MVVM/viewModels/cartViewModel/cartViewModel.dart';
import 'package:frontend/App/Resources/assetsPaths/assetsPath.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  final List<CartModel> cartData;

  const CartScreen({super.key, required this.cartData});

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
                      "Order Details",
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: Consumer<CartProvider>(
                      builder: (context, cartProvider, child) {
                        final cartItems = cartProvider.cartItems;
                        if (cartItems.isEmpty) {
                          return Center(
                            child: Text(
                              'Cart is empty',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        }
                        return ListView.separated(
                          itemCount: cartItems.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 20),
                          itemBuilder: (context, index) {
                            final item = cartItems[index];
                            return Card(
                              elevation: 4,
                              color: Colors.white,
                              // Added elevation
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: Image.network(
                                            item.image,
                                            height: 70,
                                            width: 70,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Image.asset(
                                                      AssetsPath.burgerPic,
                                                      height: 70,
                                                      width: 70,
                                                      fit: BoxFit.cover,
                                                    ),
                                          ),
                                        ),
                                        const SizedBox(width: 15),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.productName,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                item.productShortDescription,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,

                                                  // letterSpacing: 1,
                                                  color: Colors.grey,
                                                ),
                                                maxLines: 1,
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                'Size: ${item.selectedSize['name'] ?? 'N/A'}',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              // if (item
                                              //     .selectedOptionalVariants
                                              //     .isNotEmpty)
                                              //   Text(
                                              //     'Toppings: ${item.selectedOptionalVariants.map((v) => v['name']).join(', ')}',
                                              //     style: GoogleFonts.poppins(
                                              //       fontSize: 12,
                                              //       color: Colors.grey,
                                              //     ),
                                              //   ),
                                              // const SizedBox(height: 8),
                                              Text(
                                                'PKR ${item.productPrice}',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  color: const Color(
                                                    0xffD61355,
                                                  ),
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
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Colors.grey.withOpacity(
                                                  .15,
                                                ),
                                              ),
                                              child: IconButton(
                                                onPressed: () {
                                                  Provider.of<CartProvider>(
                                                    context,
                                                    listen: false,
                                                  ).updateQuantity(
                                                    item.pId,
                                                    item.quantity - 1,
                                                  );
                                                },
                                                icon: Center(
                                                  child: const Icon(
                                                    Icons.remove,
                                                    size: 18,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Text(
                                              "${item.quantity}",
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
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: const Color(0xffD61355),
                                              ),
                                              child: Center(
                                                child: IconButton(
                                                  onPressed: () {
                                                    Provider.of<CartProvider>(
                                                      context,
                                                      listen: false,
                                                    ).updateQuantity(
                                                      item.pId,
                                                      item.quantity + 1,
                                                    );
                                                  },
                                                  icon: const Icon(
                                                    Icons.add,
                                                    size: 18,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: -4,
                                    right: 0,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Color(0xffD61355),
                                        size: 24,
                                      ),
                                      onPressed: () {
                                        Provider.of<CartProvider>(
                                          context,
                                          listen: false,
                                        ).removeFromCart(item.pId);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Consumer<CartProvider>(
                    builder: (context, cartProvider, child) {
                      final totalPrice = cartProvider.getTotalPrice();
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: const LinearGradient(
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
                              padding: const EdgeInsets.all(20),
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
                                        "PKR $totalPrice",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
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
                                        "PKR 10",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
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
                                        "PKR 10",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 13),
                                  Container(
                                    height: 1,
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                  const SizedBox(height: 10),
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
                                        "PKR ${totalPrice + 10 - 10}",
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      // final cartData = cartProvider.cartItems
                                      //     .map((item) => item.toJson())
                                      //     .toList();
                                      // print("Order Data for API: $cartData");
                                      // // TODO: Implement POST API call here
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: const Color(0xffD61355),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
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
                                        color: const Color(0xffD61355),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
