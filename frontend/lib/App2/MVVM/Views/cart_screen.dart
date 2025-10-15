import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/App2/Data/Responses/status.dart';
import 'package:frontend/App2/MVVM/ViewModel/cart_view_model.dart';
import 'package:frontend/App2/Resources/assetsPath.dart';
import 'package:frontend/App2/Widgets/Common/app_contants.dart';
import 'package:frontend/App2/Widgets/Common/common_button.dart';
import 'package:frontend/App2/Widgets/Common/text_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = Provider.of<CartViewModel>(context, listen: false);
      provider.getCartProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppContants.whiteColor,
      body: Stack(
        children: [
          Image.asset(
            AssetsPath.mealMenuTopPattren,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
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
                  SizedBox(height: 25),
                  TextView(
                    text: "Order details",
                    size: 25,
                    color: AppContants.blackColor,
                    weight: 700,
                  ),
                  Expanded(
                    child: SizedBox(
                      child: Consumer<CartViewModel>(
                        builder: (context, value, child) {
                          if (value.cartProductsResponse.status ==
                              Status.Loading) {
                            return Center(child: CircularProgressIndicator());
                          } else if (value.cartProductsResponse.status ==
                              Status.Error) {
                            return Center(
                              child: Text(value.cartProductsResponse.message!),
                            );
                          } else if (value.cartProductsResponse.status ==
                              Status.Success) {
                            return ListView.builder(
                              itemCount: value.cartItems.length ?? 0,
                              itemBuilder: (context, index) {
                                final currentProduct = value.cartItems[index];

                                return Card.outlined(
                                  color: AppContants.offWhiteColor,
                                  shadowColor: AppContants.lightGrey,
                                  elevation: 5,
                                  child: SizedBox(
                                    height: 150,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                8.0,
                                              ),
                                              child: Container(
                                                width: 100,
                                                height: 150,
                                                child: Center(
                                                  child: Image.network(
                                                    currentProduct
                                                            .product
                                                            ?.image ??
                                                        "N/A",
                                                    height: 100,
                                                    width: 100,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                8.0,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        currentProduct
                                                                .product
                                                                ?.name ??
                                                            "N/A",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style:
                                                            GoogleFonts.poppins(
                                                              color: AppContants
                                                                  .blackColor,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                      ),
                                                      ...currentProduct
                                                          .product!
                                                          .variantGroups!
                                                          .map((vg) {
                                                            return Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(vg.name!),
                                                                Column(
                                                                  children: vg.options!.map((
                                                                    op,
                                                                  ) {
                                                                    return Text(
                                                                      op.name!,
                                                                      style: GoogleFonts.poppins(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    );
                                                                  }).toList(),
                                                                ),
                                                              ],
                                                            );
                                                          }),
                                                    ],
                                                  ),
                                                  Text(
                                                    'PKR: ${value.itemsPrices[index]}',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      color: const Color(
                                                        0xffD61355,
                                                      ),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xffFFE5E5),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Consumer<CartViewModel>(
                                            builder: (context, value, child) {
                                              return Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      value.updateQuantity(
                                                        quantity: 1,
                                                        index: index,
                                                        price:
                                                            currentProduct
                                                                .itemTotal ??
                                                            10,
                                                        isAddition: true,
                                                      );
                                                    },
                                                    child: Text(
                                                    "+",style: GoogleFonts.poppins(color: AppContants.redColor,fontSize: 20,fontWeight: FontWeight.w700),
                                                  ),),
                                                  Text(
                                                    value.itemsQuantity[index].toString(),
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 18,
                                                    ),
                                                  ),TextButton(
                                                    onPressed: () {
                                                      value.updateQuantity(
                                                        quantity: 1,
                                                        index: index,
                                                        price:
                                                            currentProduct
                                                                .itemTotal ??
                                                            10,
                                                        isAddition: false,
                                                      );
                                                    },
                                                    child: Text(
                                                    "-",style: GoogleFonts.poppins(color: AppContants.redColor,fontSize: 20,fontWeight: FontWeight.w700),
                                                  ),),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
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
                            borderRadius: BorderRadius.circular(10),
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
                          padding: const EdgeInsets.all(20.0),
                          child: Consumer<CartViewModel>(
                            builder: (context, value, child) => Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 8),
                                CartTotals(title: 'Sub-Total', amount: value.subTotalPrice.toString()),
                                const SizedBox(height: 8),
                                CartTotals(
                                  title: 'Delivery Charge',
                                  amount: '100',
                                ),
                                const SizedBox(height: 12),
                                CartTotals(title: 'Discount', amount: '100'),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      'PKR ${value.subTotalPrice}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {},
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
                        ),
                      ],
                    ),
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

class CartTotals extends StatelessWidget {
  final String title;
  final String amount;
  const CartTotals({super.key, required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "PKR $amount",
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
