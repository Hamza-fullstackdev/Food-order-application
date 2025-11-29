
import 'package:flutter/material.dart';
import 'package:frontend/Resources/app_colors.dart';
import 'package:frontend/Widgets/text_view.dart';


class AddressesPage extends StatelessWidget {
  const AddressesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.lightGreyColor2,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new),
                    ),
                  ),
                  const SizedBox(width: 20),
                  TextViewNormal(
                    text: "My Address",
                    colors: AppColors.blackColor,
                    isBold: true,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.lightGreyColor2,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: AppColors.whiteColor,
                            child: const Icon(
                              Icons.home_outlined,
                              color: Colors.blueAccent,
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Address Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // 🔸 Title + Action Buttons
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextViewNormal(
                                      text: 'Home',
                                      colors: AppColors.blackColor,
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.edit,
                                            color: AppColors.orangeColor,
                                            size: 22,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.delete_outline_rounded,
                                            color: AppColors.orangeColor,
                                            size: 22,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                TextViewNormal(
                                  text:
                                      '2464 Royal Ln. Mesa, New Jersey 45463',
                                  colors: AppColors.darkGreyColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
