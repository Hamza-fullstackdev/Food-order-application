import 'package:flutter/material.dart';
import 'package:frontend/Resources/app_colors.dart';
import 'package:frontend/Resources/app_routes.dart';
import 'package:frontend/Resources/assetsPath.dart';
import 'package:frontend/Widgets/common_button.dart';
import 'package:frontend/Widgets/text_view.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        color: AppColors.lightGreyColor2,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: AssetImage(AssetsPath.paymentSuccess),
                          fit: BoxFit.cover
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextViewNormal(
                      text: 'Congratulations!',
                      isBold: true,
                      size: 20,
                      colors: AppColors.blackColor,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'You successfully maked a payment,enjoy our service!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.darkBlack),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: ButtonContainerFilled(
                  width: MediaQuery.of(context).size.width,
                  function: () {
                    Navigator.popAndPushNamed(context, AppRoutes.trackOrder);
                  },
                  child: TextViewNormal(
                    text: 'Track Order',
                    colors: AppColors.whiteColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}