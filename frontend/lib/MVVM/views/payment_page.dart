// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/MVVM/ViewModel/order_provider.dart';
import 'package:frontend/MVVM/ViewModel/payment_provider.dart';
import 'package:frontend/Resources/app_colors.dart';
import 'package:frontend/Resources/app_messeges.dart';
import 'package:frontend/Resources/app_routes.dart';
import 'package:frontend/Resources/assetsPath.dart';
import 'package:frontend/Resources/status.dart';
import 'package:frontend/Widgets/common_button.dart';
import 'package:frontend/Widgets/text_view.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 24, bottom: 140),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: CircleAvatar(
                              backgroundColor: AppColors.lightGreyColor2,
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 15,
                                color: AppColors.blackColor,
                              ),
                            ),
                          ),
                          TextViewNormal(
                            text: 'Payment',
                            size: 16,
                            colors: AppColors.blackColor,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Consumer<PaymentMethodsProvider>(
                      builder: (context, value, child) => SizedBox(
                        height: 100,
                        child: ListView.builder(
                          itemCount: value.paymentMethods.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                value.setSelectedPayementMethod(index);
                                value.filterList(
                                  value.paymentMethods[index].cardType,
                                );
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: kIsWeb ? 50 : 60,
                                    width: kIsWeb ? 70 : 80,
                                    margin: EdgeInsets.only(
                                      left: 8,
                                      right: 8,
                                      top: 12,
                                      bottom: 0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.lightGreyColor2,
                                      border:
                                          value.currentPaymentMethod == index
                                          ? BoxBorder.all(
                                              width: 2,
                                              color: AppColors.orangeColor,
                                            )
                                          : null,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      image: DecorationImage(
                                        image: AssetImage(
                                          value.paymentMethods[index].cardLogo,
                                        ),
                                      ),
                                    ),
                                    child: value.currentPaymentMethod == index
                                        ? Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Positioned(
                                                top: -8,
                                                right: -6,
                                                child: Container(
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                    color: AppColors
                                                        .darkOrangeColor,
                                                    shape: BoxShape.circle,
                                                    border: BoxBorder.all(
                                                      color:
                                                          AppColors.whiteColor,
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.done,
                                                      size: 12,
                                                      color:
                                                          AppColors.whiteColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : null,
                                  ),
                                  SizedBox(height: 5),
                                  TextViewNormal(
                                    text: value.paymentMethods[index].cardType,
                                    size: 12,
                                    isBold: false,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Consumer<PaymentMethodsProvider>(
                      builder: (context, value, child) {
                        if (value.currentPaymentMethod == 0) {
                          return const SizedBox();
                        }

                        if (value.cardList.isNotEmpty) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: value.cardList.length,
                              itemBuilder: (context, i) {
                                return InkWell(
                                  onTap: () {
                                    value.setSelectedCard(i);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.lightGreyColor2,
                                      border: value.selectedCardIndex == i
                                          ? Border.all(
                                              color: AppColors.orangeColor,
                                            )
                                          : null,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextViewNormal(
                                              text:
                                                  '${value.cardList[i].cardType} Card',
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 30,
                                                  width: 60,
                                                  padding: const EdgeInsets.all(
                                                    5,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.blackColor
                                                        .withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                        value
                                                            .paymentMethods[value
                                                                .currentPaymentMethod]
                                                            .cardLogo,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                TextViewNormal(
                                                  text: value.maskCardNumber(
                                                    value.cardList[i].cardNum,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        value.selectedCardIndex == i
                                            ? Container(
                                                height: 20,
                                                width: 20,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.done,
                                                    size: 20,
                                                    color:
                                                        AppColors.orangeColor,
                                                  ),
                                                ),
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }

                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          height: 280,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: AppColors.dartWhiteColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 16.0,
                                  bottom: 16,
                                ),
                                child: Container(
                                  height: 150,
                                  width: 220,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: AssetImage(AssetsPath.dummyCard),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          value
                                              .paymentMethods[value
                                                  .currentPaymentMethod]
                                              .cardLogo,
                                        ),
                                        const SizedBox(height: 20),
                                        Container(
                                          width: 170,
                                          height: 25,
                                          decoration: BoxDecoration(
                                            color: AppColors.lightGreyColor2
                                                .withOpacity(0.8),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Container(
                                          width: 70,
                                          height: 15,
                                          decoration: BoxDecoration(
                                            color: AppColors.lightGreyColor2
                                                .withOpacity(0.8),
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Container(
                                          width: 40,
                                          height: 15,
                                          decoration: BoxDecoration(
                                            color: AppColors.lightGreyColor2
                                                .withOpacity(0.8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              TextViewNormal(
                                text:
                                    'No ${value.paymentMethods[value.currentPaymentMethod].cardType} card added',
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                ),
                                child: Text(
                                  'You can add a ${value.paymentMethods[value.currentPaymentMethod].cardType} card and save it for later',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.darkGreyColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10),

                    Consumer<PaymentMethodsProvider>(
                      builder: (context, value, child) =>
                          value.currentPaymentMethod == 0
                          ? SizedBox()
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: ButtonContainerFilled(
                                width: MediaQuery.sizeOf(context).width,
                                color: AppColors.whiteColor,
                                function: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.addCardPage,
                                  );
                                },
                                child: TextViewNormal(
                                  text: '+ ADD NEW',
                                  colors: AppColors.orangeColor,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Container(
                color: AppColors.whiteColor,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          TextViewNormal(
                            text: 'Total:',
                            size: 14,
                            colors: AppColors.darkGreyColor,
                          ),
                          TextViewNormal(
                            text: ' \$30',
                            size: 14,
                            isBold: true,
                            colors: AppColors.blackColor,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Consumer<OrderProvider>(
                        builder: (context, value, child) =>
                            ButtonContainerFilled(
                              width: MediaQuery.of(context).size.width,
                              function: () async {
                                await value.submitOrders();
                                if (value.orderResponse.status ==
                                    ResponseStatus.success) {
                                  Navigator.popAndPushNamed(
                                    context,
                                    AppRoutes.paymentSuccess,
                                  );
                                } else if (value.orderResponse.status ==
                                    ResponseStatus.failed) {
                                  MessageUtils.showSnackBar(
                                    context,
                                    value.orderResponse.message!,
                                  );
                                }
                              },
                              child:
                                  value.orderResponse.status ==
                                      ResponseStatus.loading
                                  ? Center(child: CircularProgressIndicator())
                                  : TextViewNormal(
                                      text: 'Pay & Confirm',
                                      colors: AppColors.whiteColor,
                                    ),
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
    );
  }
}
