// ignore_for_file: deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/MVVM/ViewModel/cart_provider.dart';
import 'package:frontend/MVVM/ViewModel/product_detail_provider.dart';
import 'package:frontend/MVVM/models/GetProduct_ByCategoryId.dart';
import 'package:frontend/MVVM/models/cartModel.dart';
import 'package:frontend/Resources/app_colors.dart';
import 'package:frontend/Resources/app_routes.dart';
import 'package:frontend/Widgets/common_button.dart';
import 'package:frontend/Widgets/text_view.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  Products productsModel = Products();
  String deliveryTime = '';
  String deliveryCharges = '';
  String rating = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final List args = ModalRoute.of(context)!.settings.arguments as List;
    productsModel = args[0];
    deliveryCharges = args[1];
    deliveryTime = args[2];
    rating = args[3];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: kIsWeb
                        ? MediaQuery.of(context).size.height * 0.50
                        : MediaQuery.of(context).size.height * 0.35,
                    decoration: BoxDecoration(
                      color: AppColors.darkGreyColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                      image: DecorationImage(
                        image: AssetImage(productsModel.image!),
                        fit: BoxFit.cover,
                      ),
                    ),

                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 32,
                            right: 16,
                            left: 16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: CircleAvatar(
                                  backgroundColor: AppColors.lightGreyColor2,
                                  child: Icon(Icons.arrow_back_ios, size: 15),
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: CircleAvatar(
                                  backgroundColor: AppColors.lightGreyColor,
                                  child: Icon(Icons.favorite_border, size: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 16,
                      right: 16,
                      bottom: kIsWeb
                          ? MediaQuery.of(context).size.height * 0.30
                          : MediaQuery.of(context).size.height * 0.21,
                      left: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: TextViewNormal(
                            text: productsModel.name!,
                            size: 20,
                            isBold: true,
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.star_border,
                              color: AppColors.orangeColor,
                            ),
                            SizedBox(width: 5),
                            TextViewNormal(text: rating, isBold: true),
                            SizedBox(width: 25),
                            Icon(
                              Icons.fire_truck_outlined,
                              color: AppColors.orangeColor,
                            ),
                            SizedBox(width: 5),
                            TextViewNormal(
                              text: deliveryCharges,
                              isBold: false,
                              size: 14,
                            ),
                            SizedBox(width: 25),
                            Icon(
                              Icons.lock_clock,
                              color: AppColors.orangeColor,
                            ),
                            SizedBox(width: 5),
                            TextViewNormal(
                              text: deliveryTime,
                              isBold: false,
                              size: 14,
                            ),
                          ],
                        ),
                        ReadMoreText(
                          productsModel.description!,
                          style: TextStyle(color: AppColors.darkGreyColor),
                          colorClickableText: AppColors.orangeColor,
                          trimLength: kIsWeb ? 350 : 120,
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: productsModel.variantGroups!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextViewNormal(
                                  text:
                                      productsModel.variantGroups![index].name!,
                                ),
                                ListView.builder(
                                  itemCount: productsModel
                                      .variantGroups![index]
                                      .options!
                                      .length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, i) {
                                    final Options option = productsModel
                                        .variantGroups![index]
                                        .options![i];
                                    final String groupId = productsModel
                                        .variantGroups![index]
                                        .sId
                                        .toString();

                                    if (productsModel
                                            .variantGroups![index]
                                            .maxSelectable ==
                                        1) {
                                      return Consumer<ProductDetailProvider>(
                                        builder: (context, value, child) =>
                                            RadioListTile<String>(
                                              activeColor:
                                                  AppColors.orangeColor,
                                              value: option.name!,
                                              groupValue:
                                                  value.isRadio[groupId],
                                              title: TextViewNormal(
                                                text:
                                                    "${option.name} (+${option.price})",
                                                colors: AppColors.blackColor,
                                                size: 16,
                                              ),
                                              onChanged: (selectedValue) {
                                                value.setSelectedRadio(
                                                  groupId,
                                                  selectedValue!,
                                                );
                                              },
                                            ),
                                      );
                                    } else {
                                      return Consumer<ProductDetailProvider>(
                                        builder: (context, value, child) {
                                          final bool isChecked =
                                              value.isSwitch[groupId]?.contains(
                                                option.name.toString(),
                                              ) ??
                                              false;
                                          return CheckboxListTile(
                                            value: isChecked,
                                            activeColor: AppColors.orangeColor,
                                            title: TextViewNormal(
                                              text:
                                                  "${option.name} (+${option.price})",
                                              colors: AppColors.blackColor,
                                              size: 16,
                                            ),
                                            onChanged: (checked) {
                                              value.setSelectedSwitch(
                                                groupId,
                                                option.name!,
                                              );
                                            },
                                          );
                                        },
                                      );
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                top: true,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  height: kIsWeb
                      ? MediaQuery.of(context).size.height * 0.25
                      : MediaQuery.of(context).size.height * 0.20,
                  decoration: BoxDecoration(
                    color: AppColors.lightGreyColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Consumer<ProductDetailProvider>(
                            builder: (context, value, child) => TextViewNormal(
                              text:
                                  '\$ ${(value.quantity * productsModel.price!).toStringAsFixed(2)}',
                              size: kIsWeb ? 28 : 24,
                              isBold: true,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: kIsWeb ? 12 : 2,
                              vertical: kIsWeb ? 8 : 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.blackColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              children: [
                                Consumer<ProductDetailProvider>(
                                  builder: (context, value, child) =>
                                      TextButton(
                                        onPressed: () {
                                          if (value.quantity > 1) {
                                            value.updateQuntity(
                                              value.quantity - 1,
                                            );
                                          }
                                        },
                                        child: CircleAvatar(
                                          radius: 18,
                                          backgroundColor: AppColors.darkBlack,
                                          child: TextViewLarge(
                                            text: '-',
                                            isBold: true,
                                            size: 14,
                                            colors: AppColors.whiteColor,
                                          ),
                                        ),
                                      ),
                                ),
                                const SizedBox(width: kIsWeb ? 15 : 10),
                                Consumer<ProductDetailProvider>(
                                  builder: (context, value, child) =>
                                      TextViewLarge(
                                        text: value.quantity.toString(),
                                        isBold: true,
                                        size: 18,
                                        colors: AppColors.whiteColor,
                                      ),
                                ),
                                const SizedBox(width: kIsWeb ? 15 : 10),
                                Consumer<ProductDetailProvider>(
                                  builder: (context, value, child) =>
                                      TextButton(
                                        onPressed: () {
                                          value.updateQuntity(
                                            value.quantity + 1,
                                          );
                                        },
                                        child: CircleAvatar(
                                          radius: 18,
                                          backgroundColor: AppColors.darkBlack,
                                          child: TextViewNormal(
                                            isBold: true,
                                            colors: AppColors.whiteColor,
                                            size: 14,
                                            text: '+',
                                          ),
                                        ),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Consumer<ProductDetailProvider>(
                        builder: (context, value, child) =>
                            ButtonContainerFilled(
                              function: () {
                                
                                Provider.of<CartsProvider>(
                                  context,
                                  listen: false,
                                ).addToCart(
                                  CartModel(
                                    productId: productsModel.sId!,
                                    productName: productsModel.name!,
                                    productImg: productsModel.image!,
                                    quantity: value.quantity,
                                    price: productsModel.price!,
                                    selectedVarients: value.getSelectedOptions(productsModel.variantGroups!),
                                  ),
                                );
                                Navigator.popAndPushNamed(
                                  context,
                                  AppRoutes.cartPage,
                                );
                              },
                              width: MediaQuery.of(context).size.width,
                              child: TextViewNormal(
                                text: 'Add to Cart',
                                colors: AppColors.whiteColor,
                                size: 16,
                                isBold: true,
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
