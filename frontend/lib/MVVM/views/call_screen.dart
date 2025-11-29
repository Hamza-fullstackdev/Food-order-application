import 'package:flutter/material.dart';
import 'package:frontend/Resources/app_colors.dart';
import 'package:frontend/Widgets/text_view.dart';


class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: AppColors.darkBlack,
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 30),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                       CircleAvatar(
                    backgroundColor: AppColors.lightGreyColor2,
                    minRadius: 40,
                  ),
                  SizedBox(height: 20,),
                  TextViewLarge(text: 'Robert Fox',size: 16,),
                  TextViewNormal(text: 'Connecting...',size: 14,colors: AppColors.darkGreyColor,),

                  SizedBox(height: 30,),
                 
                    ],
                  ), 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        minRadius: 20,
                        backgroundColor: AppColors.lightGreyColor2,
                        child: Icon(Icons.mic_off_outlined,color: AppColors.blackColor,),
                      ),
                      CircleAvatar(
                        minRadius: 20,
                        backgroundColor: AppColors.orangeColor,
                        child: Icon(Icons.phone_outlined,color: AppColors.whiteColor,),
                      ),
                      CircleAvatar(
                        minRadius: 20,
                        backgroundColor: AppColors.lightGreyColor2,
                        child: Icon(Icons.volume_down_outlined,color: AppColors.blackColor,),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}