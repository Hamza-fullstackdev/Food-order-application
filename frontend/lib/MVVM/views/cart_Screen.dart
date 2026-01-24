// ignore_for_file: file_names, collection_methods_unrelated_type, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/MVVM/ViewModel/address_provider.dart';
import 'package:frontend/MVVM/ViewModel/cart_provider.dart';
import 'package:frontend/MVVM/ViewModel/order_provider.dart';
import 'package:frontend/MVVM/models/cart_model.dart';
import 'package:frontend/Resources/app_colors.dart';
import 'package:frontend/Resources/app_messeges.dart';
import 'package:frontend/Resources/app_routes.dart';
import 'package:frontend/Resources/status.dart';
import 'package:frontend/Widgets/common_button.dart';
import 'package:frontend/Widgets/text_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CartsProvider>(context, listen: false).calculateTotal();
      Provider.of<CartsProvider>(context, listen: false).getCarts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height,
              color: AppColors.whiteColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: CircleAvatar(
                              backgroundColor: AppColors.lightBlackColor,
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 15,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          TextViewNormal(
                            text: 'Cart',
                            size: 20,
                            colors: AppColors.blackColor,
                          ),
                        ],
                      ),
                      Consumer<CartsProvider>(
                        builder: (context, value, child) => TextButton(
                          onPressed: () {
                            value.setIsEditing();
                          },
                          child: TextViewNormal(
                            size: 14,
                            text: value.isEditing ? 'Done' : 'EDIT Items',
                            colors: value.isEditing
                                ? Colors.green.shade400
                                : AppColors.greyColorDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Consumer<CartsProvider>(
                      builder: (context, value, child) {
                        if (value.getAllCartResponse.status ==
                            ResponseStatus.loading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (value.getAllCartResponse.status ==
                            ResponseStatus.failed) {
                          return Center(
                            child: TextViewNormal(
                              text: value.getAllCartResponse.message ?? '',
                            ),
                          );
                        }
                        final List<CartModel> cartList =
                            value.getAllCartResponse.data ?? [];
                        return Container(
                          margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.33,
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: cartList.length,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            itemBuilder: (context, index) {
                              final CartModel currentCart = cartList[index];

                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 8),

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.lightGrey,
                                ),
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: 8,
                                          top: 8,
                                          bottom: 8,
                                        ),
                                        height:
                                            MediaQuery.of(context).size.height *
                                            0.12,
                                        width: kIsWeb
                                            ? MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.25
                                            : MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.25,

                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          color: AppColors.darkBlack,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              currentCart.product!.image!,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(top: 10),
                                              width: kIsWeb
                                                  ? MediaQuery.widthOf(
                                                          context,
                                                        ) *
                                                        0.70
                                                  : MediaQuery.widthOf(
                                                          context,
                                                        ) *
                                                        0.58,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  TextViewNormal(
                                                    text: currentCart
                                                        .product!
                                                        .name!,
                                                    size: 14,
                                                    colors: AppColors.darkBlack,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      cartList.remove(index);
                                                      value.removeFromCart(
                                                        currentCart.sId!,
                                                      );
                                                    },
                                                    child: Visibility(
                                                      visible: value.isEditing,
                                                      child: CircleAvatar(
                                                        radius: 10,
                                                        backgroundColor:
                                                            Colors.red.shade700,

                                                        child: TextViewNormal(
                                                          text: 'X',
                                                          isBold: true,
                                                          size: 14,
                                                          colors: AppColors
                                                              .whiteColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              child: Wrap(
                                                direction: Axis.horizontal,
                                                alignment: WrapAlignment.start,
                                                spacing: 5,
                                                runSpacing: 3,
                                                children: currentCart
                                                    .product!
                                                    .variantGroups!
                                                    .map((varient) {
                                                      return Wrap(
                                                        direction:
                                                            Axis.horizontal,
                                                        alignment:
                                                            WrapAlignment.start,
                                                        children: varient.options!.map((
                                                          options,
                                                        ) {
                                                          return TextViewNormal(
                                                            text:
                                                                '${options.name}, ',
                                                            colors: AppColors
                                                                .darkGreyColor,
                                                          );
                                                        }).toList(),
                                                      );
                                                    })
                                                    .toList(),
                                              ),
                                            ),

                                            const Spacer(),
                                            Container(
                                              margin: EdgeInsets.only(
                                                bottom: 10,
                                              ),
                                              width: kIsWeb
                                                  ? MediaQuery.widthOf(
                                                          context,
                                                        ) *
                                                        0.70
                                                  : MediaQuery.widthOf(
                                                          context,
                                                        ) *
                                                        0.58,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Consumer<CartsProvider>(
                                                    builder:
                                                        (
                                                          context,
                                                          value,
                                                          child,
                                                        ) => TextViewNormal(
                                                          text:
                                                              (value.price[index]! *
                                                                      value
                                                                          .quantity[index]!)
                                                                  .toString(),
                                                          size: 12,
                                                          isBold: true,
                                                          colors: AppColors
                                                              .blackColor,
                                                        ),
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () async {
                                                          value.decrement(
                                                            currentCart.sId!,
                                                            index,
                                                          );
                                                        },
                                                        child: CircleAvatar(
                                                          radius: 14,
                                                          backgroundColor:
                                                              AppColors
                                                                  .darkGreyColor
                                                                  .withOpacity(
                                                                    0.7,
                                                                  ),
                                                          child: TextViewLarge(
                                                            text: '-',
                                                            isBold: true,
                                                            size: 14,
                                                            colors: AppColors
                                                                .whiteColor,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      TextViewLarge(
                                                        text: value
                                                            .quantity[index]
                                                            .toString(),
                                                        isBold: true,
                                                        size: 14,
                                                        colors: AppColors
                                                            .whiteColor,
                                                      ),
                                                      SizedBox(width: 10),
                                                      GestureDetector(
                                                        onTap: () async {
                                                          value.increment(
                                                            currentCart.sId!,
                                                            index,
                                                          );
                                                        },
                                                        child: CircleAvatar(
                                                          radius: 14,
                                                          backgroundColor:
                                                              AppColors
                                                                  .darkGreyColor
                                                                  .withOpacity(
                                                                    0.7,
                                                                  ),
                                                          child: TextViewNormal(
                                                            isBold: true,
                                                            colors: AppColors
                                                                .whiteColor,
                                                            size: 14,
                                                            text: '+',
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: kIsWeb
                    ? MediaQuery.of(context).size.height * 0.40
                    : MediaQuery.of(context).size.height * 0.35,

                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.orangeColor.withOpacity(0.9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextViewNormal(
                            text: 'Delivery Address',
                            size: 14,
                            colors: AppColors.whiteColor,
                          ),
                          Consumer<AddressProvider>(
                            builder: (context, value, child) => GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                context,
                                AppRoutes.allAddressPage,
                                arguments: value.latLng,
                              ),
                              child: Icon(
                                Icons.edit_location_outlined,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 57,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: AppColors.lightGreyColor2,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Consumer<AddressProvider>(
                            builder: (context, value, child) => Text(
                              softWrap: true,
                              maxLines: 2,
                              value.currentAddress,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff4B5563),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      Row(
                        children: [
                          TextViewNormal(
                            text: 'Price:',
                            size: 12,
                            isBold: true,
                            // ignore: deprecated_member_use
                            colors: AppColors.whiteColor,
                          ),
                          Spacer(),
                          Consumer<CartsProvider>(
                            builder: (context, value, child) => TextViewNormal(
                              text: (value.totalPrice).toString(),
                              size: 14,
                              colors: AppColors.whiteColor.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Consumer<CartsProvider>(
                        builder: (context, value, child) =>
                            ButtonContainerFilled(
                              color: AppColors.whiteColor,
                              function: () async {
                                final provider = Provider.of<OrderProvider>(
                                  context,
                                  listen: false,
                                );
                                await provider.submitOrders();
                                if (provider.orderResponse.status ==
                                    ResponseStatus.success) {
                                  MessageUtils.showSnackBar(
                                    context,
                                    "Payment Success",
                                  );
                                  Navigator.pushReplacementNamed(
                                    context,
                                    // result: Transform.flip(),
                                    AppRoutes.paymentSuccess,
                                  );
                                } else if (provider.orderResponse.status ==
                                    ResponseStatus.failed) {
                                  MessageUtils.showSnackBar(
                                    context,
                                    provider.orderResponse.message ??
                                        'Failed to process order...',
                                  );
                                }

                                // final isPayment = await value
                                //     .setUpPayment();
                                // if (isPayment == true) {
                                //   MessageUtils.showSnackBar(
                                //     context,
                                //     "Payment Success",
                                //   );
                                //   Navigator.pushReplacementNamed(
                                //     context,
                                //     AppRoutes.paymentSuccess,
                                //   );
                                // } else {
                                //   MessageUtils.showSnackBar(
                                //     context,
                                //     isPayment.toString(),
                                //   );
                                // }
                              },
                              height: 57,
                              width: MediaQuery.of(context).size.width,
                              child:
                                  Provider.of<OrderProvider>(
                                        context,
                                      ).orderResponse.status ==
                                      ResponseStatus.loading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.orangeColor,
                                      ),
                                    )
                                  : TextViewNormal(
                                      text: 'Place Order',
                                      colors: AppColors.orangeColor,
                                    ),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
