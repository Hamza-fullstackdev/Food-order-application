// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:frontend/Resources/app_colors.dart';
import 'package:frontend/Resources/assetsPath.dart';
import 'package:frontend/Widgets/text_view.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 32, horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.lightGreyColor2,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_back_ios_new),
                      ),
                    ),
                    SizedBox(width: 20),
                    TextViewNormal(
                      text: "Profile",
                      colors: AppColors.blackColor,
                    ),
                  ],
                ),
                CircleAvatar(
                  backgroundColor: AppColors.lightGreyColor,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.more_horiz),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(AssetsPath.profilePic,),fit: BoxFit.cover
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextViewNormal(text: 'Vishal Khadok'),
                    TextViewNormal(
                      text: 'I love fast food',
                      colors: AppColors.darkGreyColor,
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppColors.lightGreyColor2,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: AppColors.whiteColor,
                                    child: Icon(
                                      Icons.person_4_outlined,
                                      color: AppColors.darkOrangeColor,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  TextViewNormal(text: 'Personal Info'),
                                ],
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.arrow_forward_ios_rounded),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: AppColors.whiteColor,
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  TextViewNormal(text: 'Favourite'),
                                ],
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.arrow_forward_ios_rounded),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(20),
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppColors.lightGreyColor2,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: AppColors.whiteColor,
                                    child: Icon(
                                      Icons.notifications_active_outlined,
                                      color: Colors.orange.shade500,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  TextViewNormal(text: 'Notifications'),
                                ],
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.arrow_forward_ios_rounded),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: AppColors.whiteColor,
                                    child: Icon(
                                      Icons.payment,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  TextViewNormal(text: 'Payment Method'),
                                ],
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.arrow_forward_ios_rounded),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(20),
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppColors.lightGreyColor2,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: AppColors.whiteColor,
                                    child: Icon(
                                      Icons.question_mark_rounded,
                                      color: Colors.deepOrangeAccent.shade400,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  TextViewNormal(text: 'FAQs'),
                                ],
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.arrow_forward_ios_rounded),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: AppColors.whiteColor,
                                    child: Icon(
                                      Icons.reviews_outlined,
                                      color: Colors.cyan,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  TextViewNormal(text: 'User Reviews'),
                                ],
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.arrow_forward_ios_rounded),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: AppColors.whiteColor,
                                    child: Icon(
                                      Icons.settings,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  TextViewNormal(text: 'Settings'),
                                ],
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.arrow_forward_ios_rounded),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(20),
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppColors.lightGreyColor2,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: AppColors.whiteColor,
                                child: Icon(
                                  Icons.question_mark_rounded,
                                  color: Colors.deepOrangeAccent.shade400,
                                ),
                              ),
                              SizedBox(width: 20),
                              TextViewNormal(text: 'FAQs'),
                            ],
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_forward_ios_rounded),
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
      ),
    );
  }
}
