// import 'package:flutter/material.dart';
// import 'package:frontend/App/MVVM/models/GetProduct_ByCategoryId.dart';
// import 'package:frontend/App/MVVM/views/cart_Screen.dart';
// import 'package:frontend/App2/Widgets/Common/app_contants.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ProductDetailScreen extends StatefulWidget {
//   final String imagePath;
//   final String name;
//   final String productPrice;
//   final String detail;
//   final List<VariantGroups>? variants;

//   const ProductDetailScreen({
//     super.key,
//     required this.imagePath,
//     required this.name,
//     required this.productPrice,
//     required this.detail,
//     this.variants,
//   });

//   @override
//   State<ProductDetailScreen> createState() => _ProductDetailScreenState();
// }

// class _ProductDetailScreenState extends State<ProductDetailScreen> {
//   Map<String, Options?> selectedVariants = {}; // For size (single selection)
//   Map<String, List<Options>> selectedOptionalVariants = {};

//   @override
//   void initState() {
//     super.initState();

//     if (widget.variants != null) {
//       for (var variant in widget.variants!) {
//         if (variant.name == 'Size') {
//           selectedVariants[variant.name ?? ''] = variant.options!.isNotEmpty
//               ? variant.options![0]
//               : null;
//         } else {
//           selectedOptionalVariants[variant.name ?? ''] = [];
//         }
//       }
//     }
//   }

//   bool isSizeSelected() {
//     return selectedVariants.containsKey('Size') &&
//         selectedVariants['Size'] != null;
//   }

//   bool canSelectMore(String variantName) {
//     return (selectedOptionalVariants[variantName]?.length ?? 0) < 2;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               height: 400,
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Color(0xffFFC1E3), Color(0xffDC8CB1)],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//               ),
//               child: Image.network(
//                 widget.imagePath,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) =>
//                     const Icon(Icons.error, size: 120, color: Colors.pink),
//               ),
//             ),

//             Container(
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(16),
//                   topRight: Radius.circular(16),
//                 ),
//               ),
//               padding: const EdgeInsets.all(25.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Center(
//                     child: Container(
//                       margin: const EdgeInsets.only(bottom: 20),
//                       height: 4,
//                       width: 50,
//                       decoration: BoxDecoration(
//                         color: Colors.pink[100],
//                         borderRadius: BorderRadius.circular(2),
//                       ),
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Container(
//                         height: 35,
//                         width: 90,
//                         decoration: BoxDecoration(
//                           color: const Color(0xffFFE5E5),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Center(
//                           child: Text(
//                             'Popular',
//                             style: GoogleFonts.poppins(
//                               fontSize: 12,
//                               color: const Color(0xffD61355),
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const Spacer(),
//                       CircleAvatar(
//                         radius: 18,
//                         backgroundColor: const Color(0xffFFE5E5),
//                         child: const Icon(
//                           Icons.location_on_rounded,
//                           color: Color(0xffD61355),
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       const CircleAvatar(
//                         radius: 18,
//                         backgroundColor: Color(0xffE5E5E5),
//                         child: Icon(Icons.favorite, color: Colors.black),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Text(
//                     widget.name,
//                     style: GoogleFonts.poppins(
//                       fontSize: 27,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                   Row(
//                     children: [
//                       const Icon(
//                         Icons.star_half_sharp,
//                         color: Colors.amber,
//                         size: 18,
//                       ),
//                       const SizedBox(width: 5),
//                       Text(
//                         '4.8 Rating',
//                         style: GoogleFonts.poppins(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.grey[400],
//                         ),
//                       ),
//                       const SizedBox(width: 25),
//                       const Icon(
//                         Icons.shopping_bag,
//                         color: Color(0xffD61355),
//                         size: 18,
//                       ),
//                       const SizedBox(width: 5),
//                       Text(
//                         '7000+ Orders',
//                         style: GoogleFonts.poppins(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.grey[400],
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Text(
//                     widget.detail,
//                     style: GoogleFonts.poppins(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black,
//                     ),
//                     maxLines: 5,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 20),
//                   widget.variants != null && widget.variants!.isNotEmpty
//                       ? ListView.builder(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: widget.variants!.length,
//                           itemBuilder: (context, index) {
//                             final variant = widget.variants![index];
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   variant.name ?? 'Unknown Variant',
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 if (variant.name == 'Size')
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'Required*',
//                                         style: GoogleFonts.poppins(
//                                           fontSize: 14,
//                                           color: AppContants.redColor,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                       ListView.builder(
//                                         shrinkWrap: true,
//                                         physics:
//                                             const NeverScrollableScrollPhysics(),
//                                         itemCount: variant.options!.length,
//                                         itemBuilder: (context, optionIndex) {
//                                           final option =
//                                               variant.options![optionIndex];
//                                           return RadioListTile<Options>(
//                                             title: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Text(
//                                                   option.name ?? 'N/A',
//                                                   style: GoogleFonts.poppins(
//                                                     fontSize: 14,
//                                                     fontWeight: FontWeight.w500,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   'PKR ${option.price ?? '0'}',
//                                                   style: GoogleFonts.poppins(
//                                                     fontSize: 14,
//                                                     fontWeight: FontWeight.w500,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             value: option,
//                                             groupValue:
//                                                 selectedVariants[variant.name],
//                                             onChanged: (Options? value) {
//                                               setState(() {
//                                                 selectedVariants[variant.name ??
//                                                         ''] =
//                                                     value;
//                                               });
//                                             },
//                                             activeColor: const Color(
//                                               0xffD61355,
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                     ],
//                                   )
//                                 // Optional Variants (CheckboxListTile, max 2)
//                                 else
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'Max Selectable: 2',
//                                         style: GoogleFonts.poppins(
//                                           fontSize: 14,
//                                           color: AppContants.redColor,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                       ListView.builder(
//                                         shrinkWrap: true,
//                                         physics:
//                                             const NeverScrollableScrollPhysics(),
//                                         itemCount: variant.options!.length,
//                                         itemBuilder: (context, optionIndex) {
//                                           final option =
//                                               variant.options![optionIndex];
//                                           final isSelected =
//                                               selectedOptionalVariants[variant
//                                                           .name ??
//                                                       '']
//                                                   ?.contains(option) ??
//                                               false;
//                                           return CheckboxListTile(
//                                             title: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Text(
//                                                   option.name ?? 'N/A',
//                                                   style: GoogleFonts.poppins(
//                                                     fontSize: 14,
//                                                     fontWeight: FontWeight.w500,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   'PKR ${option.price ?? '0'}',
//                                                   style: GoogleFonts.poppins(
//                                                     fontSize: 14,
//                                                     fontWeight: FontWeight.w500,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             value: isSelected,
//                                             onChanged: (bool? value) {
//                                               setState(() {
//                                                 if (value == true &&
//                                                     canSelectMore(
//                                                       variant.name ?? '',
//                                                     )) {
//                                                   selectedOptionalVariants[variant
//                                                               .name ??
//                                                           '']
//                                                       ?.add(option);
//                                                 } else if (value == false) {
//                                                   selectedOptionalVariants[variant
//                                                               .name ??
//                                                           '']
//                                                       ?.remove(option);
//                                                 }
//                                               });
//                                             },
//                                             activeColor: const Color(
//                                               0xffD61355,
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                 const SizedBox(height: 12),
//                               ],
//                             );
//                           },
//                         )
//                       : Text(
//                           'No variants available',
//                           style: GoogleFonts.poppins(
//                             fontSize: 14,
//                             color: Colors.grey,
//                           ),
//                         ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () {
//                       if (!isSizeSelected()) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text(
//                               'Please select a size',
//                               style: GoogleFonts.poppins(fontSize: 14),
//                             ),
//                             backgroundColor: AppContants.redColor,
//                             duration: const Duration(seconds: 2),
//                           ),
//                         );
//                         return;
//                       }
//                       print('Selected Size: ${selectedVariants['Size']?.name}');
//                       print(
//                         'Selected Optional Variants: $selectedOptionalVariants',
//                       );
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const CartScreen(),
//                         ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       backgroundColor: const Color(0xffD61355),
//                       minimumSize: const Size(double.infinity, 60),
//                     ),
//                     child: Text(
//                       'Add To Cart',
//                       style: GoogleFonts.poppins(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:frontend/App/MVVM/models/GetProduct_ByCategoryId.dart';
import 'package:frontend/App/MVVM/models/cartModel.dart';
import 'package:frontend/App/MVVM/viewModels/cartViewModel/cartViewModel.dart';
import 'package:frontend/App/MVVM/views/cart_Screen.dart';
import 'package:frontend/App2/Widgets/Common/app_contants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final String pId;
  final String imagePath;
  final String name;
  final String productPrice;
  final String detail;
  final String shortDetail;
  final List<VariantGroups>? variants;

  const ProductDetailScreen({
    super.key,
    required this.pId,
    required this.imagePath,
    required this.name,
    required this.productPrice,
    required this.detail,
    required this.shortDetail,
    this.variants,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  Map<String, Options?> selectedVariants = {};
  Map<String, List<Options>> selectedOptionalVariants = {};

  @override
  void initState() {
    super.initState();
    if (widget.variants != null) {
      for (var variant in widget.variants!) {
        if (variant.name == 'Size') {
          selectedVariants[variant.name ?? ''] = variant.options!.isNotEmpty
              ? variant.options![0]
              : null;
        } else {
          selectedOptionalVariants[variant.name ?? ''] = [];
        }
      }
    }
  }

  bool isSizeSelected() {
    return selectedVariants.containsKey('Size') &&
        selectedVariants['Size'] != null;
  }

  bool canSelectMore(String variantName) {
    return (selectedOptionalVariants[variantName]?.length ?? 0) < 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xffFFC1E3), Color(0xffDC8CB1)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Image.network(
                widget.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error, size: 120, color: Colors.pink),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      height: 4,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.pink[100],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 35,
                        width: 90,
                        decoration: BoxDecoration(
                          color: const Color(0xffFFE5E5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'Popular',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color(0xffD61355),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: const Color(0xffFFE5E5),
                        child: const Icon(
                          Icons.location_on_rounded,
                          color: Color(0xffD61355),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const CircleAvatar(
                        radius: 18,
                        backgroundColor: Color(0xffE5E5E5),
                        child: Icon(Icons.favorite, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.name,
                    style: GoogleFonts.poppins(
                      fontSize: 27,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_half_sharp,
                        color: Colors.amber,
                        size: 18,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '4.8 Rating',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[400],
                        ),
                      ),
                      const SizedBox(width: 25),
                      const Icon(
                        Icons.shopping_bag,
                        color: Color(0xffD61355),
                        size: 18,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '7000+ Orders',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.detail,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 20),
                  widget.variants != null && widget.variants!.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.variants!.length,
                          itemBuilder: (context, index) {
                            final variant = widget.variants![index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  variant.name ?? 'Unknown Variant',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                if (variant.name == 'Size')
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Required*',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: AppContants.redColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: variant.options!.length,
                                        itemBuilder: (context, optionIndex) {
                                          final option =
                                              variant.options![optionIndex];
                                          return RadioListTile<Options>(
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  option.name ?? 'N/A',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  'PKR ${option.price ?? '0'}',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            value: option,
                                            groupValue:
                                                selectedVariants[variant.name],
                                            onChanged: (Options? value) {
                                              setState(() {
                                                selectedVariants[variant.name ??
                                                        ''] =
                                                    value;
                                              });
                                            },
                                            activeColor: const Color(
                                              0xffD61355,
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  )
                                else
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Max Selectable: 2',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: AppContants.redColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: variant.options!.length,
                                        itemBuilder: (context, optionIndex) {
                                          final option =
                                              variant.options![optionIndex];
                                          final isSelected =
                                              selectedOptionalVariants[variant
                                                          .name ??
                                                      '']
                                                  ?.contains(option) ??
                                              false;
                                          return CheckboxListTile(
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  option.name ?? 'N/A',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  'PKR ${option.price ?? '0'}',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            value: isSelected,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                if (value == true &&
                                                    canSelectMore(
                                                      variant.name ?? '',
                                                    )) {
                                                  selectedOptionalVariants[variant
                                                              .name ??
                                                          '']
                                                      ?.add(option);
                                                } else if (value == false) {
                                                  selectedOptionalVariants[variant
                                                              .name ??
                                                          '']
                                                      ?.remove(option);
                                                }
                                              });
                                            },
                                            activeColor: const Color(
                                              0xffD61355,
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                const SizedBox(height: 10),
                              ],
                            );
                          },
                        )
                      : Text(
                          'No variants available',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (!isSizeSelected()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Please select a size',
                              style: GoogleFonts.poppins(fontSize: 14),
                            ),
                            backgroundColor: AppContants.redColor,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                        return;
                      }
                      // Create CartModel
                      final cartModel = CartModel(
                        pId: widget.pId,
                        image: widget.imagePath,
                        productName: widget.name,
                        productShortDescription: widget.shortDetail,
                        productPrice: widget.productPrice,
                        selectedSize: {
                          'name': selectedVariants['Size']?.name,
                          'id': selectedVariants['Size']?.sId,
                        },
                        selectedOptionalVariants: selectedOptionalVariants
                            .entries
                            .expand(
                              (entry) => entry.value.map(
                                (option) => {
                                  'name': option.name,
                                  'id': option.sId,
                                },
                              ),
                            )
                            .toList(),
                      );
                      Provider.of<CartProvider>(
                        context,
                        listen: false,
                      ).addToCart(cartModel);
                      // Navigate to CartScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartScreen(
                            cartData: Provider.of<CartProvider>(
                              context,
                              listen: false,
                            ).cartItems,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: const Color(0xffD61355),
                      minimumSize: const Size(double.infinity, 60),
                    ),
                    child: Text(
                      'Add To Cart',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
