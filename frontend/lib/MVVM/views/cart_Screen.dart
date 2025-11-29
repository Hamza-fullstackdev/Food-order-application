// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/MVVM/ViewModel/cart_provider.dart';
import 'package:frontend/MVVM/models/cartModel.dart';
import 'package:frontend/Resources/app_colors.dart';
import 'package:frontend/Resources/app_routes.dart';
import 'package:frontend/Widgets/common_button.dart';
import 'package:frontend/Widgets/text_view.dart';
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
              color: AppColors.blackColor,
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
                            colors: AppColors.whiteColor,
                          ),
                        ],
                      ),
                      Consumer<CartsProvider>(
                        builder: (context, value, child) => TextButton(
                          onPressed: () {
                            value.setIsEditing();
                          },
                          child: TextViewNormal(
                            text: value.isEditing ? 'Done' : 'EDIT Items',
                            colors: value.isEditing
                                ? Colors.green.shade400
                                : AppColors.darkOrangeColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Consumer<CartsProvider>(
                      builder: (context, value, child) {
                        return Container(
                          margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.33,
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: value.cartList.length,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            itemBuilder: (context, index) {
                              final CartModel currentCart =
                                  value.cartList[index];
                                  
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 8),

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.darkBlack,
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
                                          color: AppColors.greyColorlight,
                                          image: DecorationImage(
                                            image: AssetImage(
                                              currentCart.productImg,
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
                                                    text:
                                                        currentCart.productName,
                                                    size: 14,
                                                    colors:
                                                        AppColors.whiteColor,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      value.removeToCart(index);
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
                                                    .selectedVarients
                                                    .map((varient) {
                                                     final List optionIds =
                                                          varient['optionIds'];
                                                      return TextViewNormal(
                                                        text:
                                                            '${optionIds.join(', ')}, ',
                                                        colors: AppColors
                                                            .darkGreyColor,
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
                                                              (currentCart.price *
                                                                      (value.quantity[index] ??
                                                                          currentCart
                                                                              .quantity))
                                                                  .toString(),
                                                          size: 14,
                                                          colors: AppColors
                                                              .whiteColor,
                                                        ),
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          value.decrement(
                                                            index,
                                                          );
                                                        },
                                                        child: CircleAvatar(
                                                          radius: 14,
                                                          backgroundColor:
                                                              AppColors
                                                                  .orangeColor,
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
                                                        text:
                                                            (value.quantity[index] ??
                                                                    currentCart
                                                                        .quantity)
                                                                .toString()
                                                                .toString(),
                                                        isBold: true,
                                                        size: 14,
                                                        colors: AppColors
                                                            .whiteColor,
                                                      ),
                                                      SizedBox(width: 10),
                                                      InkWell(
                                                        onTap: () {
                                                          value.increment(
                                                            index,
                                                          );
                                                        },
                                                        child: CircleAvatar(
                                                          radius: 14,
                                                          backgroundColor:
                                                              AppColors
                                                                  .orangeColor,
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
                  color: AppColors.whiteColor,
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
                            colors: AppColors.darkBlack,
                          ),
                          InkWell(
                            onTap: () => Navigator.pushNamed(
                              context,
                              AppRoutes.addAddressPage,
                            ),
                            child: TextViewNormal(
                              text: 'Edit',
                              colors: AppColors.orangeColor,
                              size: 16,
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
                          child: TextViewNormal(
                            text: '2118 Thornridge Cir. Syracuse',
                            size: 12,
                            // ignore: deprecated_member_use
                            colors: AppColors.blackColor.withOpacity(0.7),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              TextViewNormal(
                                text: 'Total:',
                                size: 12,
                                // ignore: deprecated_member_use
                                colors: AppColors.blackColor.withOpacity(0.7),
                              ),

                              Consumer<CartsProvider>(
                                builder: (context, value, child) =>
                                    TextViewNormal(
                                      text: (value.price).toString(),
                                      size: 14,
                                      colors: AppColors.blackColor,
                                    ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextViewNormal(
                                text: 'Breakdown',
                                colors: AppColors.orangeColor,
                                size: 12,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: AppColors.darkGreyColor,
                                size: 16,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Consumer<CartsProvider>(
                        builder: (context, value, child) =>
                            ButtonContainerFilled(
                              function: () {
                                Navigator.pushNamed(context, AppRoutes.paymentPage);
                              },
                              height: 57,
                              width: MediaQuery.of(context).size.width,
                              child: TextViewNormal(
                                text: 'Place Order',
                                colors: AppColors.whiteColor,
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
