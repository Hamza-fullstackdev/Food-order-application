import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Resources/app_colors.dart';
import 'package:frontend/Resources/app_routes.dart';
import 'package:frontend/Resources/assetsPath.dart';
import 'package:frontend/Widgets/text_view.dart';

class TrackOrder extends StatelessWidget {
  const TrackOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(color: AppColors.lightGreyColor2),
            DraggableScrollableSheet(
              maxChildSize: 0.7,
              initialChildSize: kIsWeb ? 0.25 : 0.15,
              expand: true,
              minChildSize: 0.15,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(16),
                                  height: kIsWeb ? 120 : 60,
                                  width: kIsWeb ? 150 : 70,
                                  decoration: BoxDecoration(
                                    color: AppColors.lightGreyColor2,
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: AssetImage(AssetsPath.foodImg),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 16,
                                    bottom: 16,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextViewNormal(
                                        text: 'Uttora Coffee House',
                                        colors: AppColors.blackColor,
                                        size: 18,
                                      ),

                                      TextViewNormal(
                                        text: 'Orderd at 06 Sept, 10:00pm',
                                        colors: AppColors.darkGreyColor,
                                        size: 14,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                            0.5,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: 2,
                                          itemBuilder: (context, index) {
                                            return TextViewNormal(
                                              text: '2x Burger',
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            TextViewLarge(
                              text: '20 Min',
                              size: 20,
                              isBold: true,
                            ),
                            TextViewNormal(
                              text: 'Estimated delivery time',
                              colors: AppColors.darkGreyColor,
                            ),

                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                    children: [
                                      CircleAvatar(
                                        maxRadius: 12,
                                        backgroundColor: AppColors.orangeColor,
                                        child: Icon(
                                          Icons.check,
                                          color: AppColors.whiteColor,
                                          size: 12,
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                      TextViewNormal(
                                        text: 'Your order has been received',
                                        colors: AppColors.orangeColor,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        maxRadius: 12,
                                        backgroundColor: AppColors.orangeColor,
                                        child: Icon(
                                          Icons.check,
                                          color: AppColors.whiteColor,
                                          size: 12,
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                      Expanded(
                                        child: TextViewNormal(
                                          text:
                                              'The restaurant is preparing your food',
                                          colors: AppColors.orangeColor,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                    children: [
                                      CircleAvatar(
                                        maxRadius: 12,
                                        backgroundColor:
                                            AppColors.darkGreyColor,
                                        child: Icon(
                                          Icons.check,
                                          color: AppColors.whiteColor,
                                          size: 12,
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                      Expanded(
                                        child: TextViewNormal(
                                          text:
                                              'Your order has been picked up for delivery',
                                          colors: AppColors.darkGreyColor,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        maxRadius: 12,
                                        backgroundColor:
                                            AppColors.darkGreyColor,
                                        child: Icon(
                                          Icons.check,
                                          color: AppColors.whiteColor,
                                          size: 12,
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                      TextViewNormal(
                                        text: 'Order arriving soon!',
                                        colors: AppColors.darkGreyColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.12,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 16,
                                  right: 16,
                                  bottom: 16,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: AssetImage(
                                                AssetsPath.profilePic,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextViewNormal(text: 'Robert F.'),
                                            TextViewNormal(
                                              text: 'Courier',
                                              colors: AppColors.darkGreyColor,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              AppColors.orangeColor,

                                          child: IconButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                context,
                                                AppRoutes.callScreen,
                                              );
                                            },
                                            icon: Icon(
                                              Icons.phone_outlined,
                                              shadows: [
                                                Shadow(
                                                  color:
                                                      AppColors.lightGreyColor,
                                                ),

                                                Shadow(
                                                  color:
                                                      AppColors.lightGreyColor2,
                                                ),

                                                Shadow(
                                                  color:
                                                      AppColors.darkGreyColor,
                                                ),
                                              ],
                                              color: AppColors.whiteColor,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 20),

                                        CircleAvatar(
                                          backgroundColor:
                                              AppColors.orangeColor,

                                          child: IconButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                context,
                                                AppRoutes.chatScreen,
                                              );
                                            },
                                            icon: Icon(
                                              Icons.message_outlined,
                                              shadows: [
                                                Shadow(
                                                  color:
                                                      AppColors.lightGreyColor,
                                                ),

                                                Shadow(
                                                  color:
                                                      AppColors.lightGreyColor2,
                                                ),

                                                Shadow(
                                                  color:
                                                      AppColors.darkGreyColor,
                                                ),
                                              ],
                                              color: AppColors.whiteColor,
                                            ),
                                          ),
                                        ),
                                      ],
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
                );
              },
            ),
            Positioned(
              top: 20,
              left: 20,
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.blackColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                  TextViewNormal(
                    text: 'Track Order',
                    size: 16,
                    colors: AppColors.blackColor,
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