import 'package:flutter/material.dart';
import 'package:frontend/Resources/app_colors.dart';
import 'package:frontend/Resources/app_routes.dart';
import 'package:frontend/Widgets/intro_page_items.dart';
import 'package:frontend/Widgets/text_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with TickerProviderStateMixin {
  late PageController _pageController;
  late final TextEditingController _nameController;
  late final TextEditingController _signupEmailController;
  late final TextEditingController _signupPassController;

  late final TextEditingController _loginEmailController;
  late final TextEditingController _loginPassController;
  late int _itemCount;

  @override
  void initState() {
    _pageController = PageController();
    _nameController = TextEditingController();
    _signupEmailController = TextEditingController();
    _signupPassController = TextEditingController();
    _loginEmailController = TextEditingController();
    _loginPassController = TextEditingController();
    _itemCount = 3;
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _signupEmailController.dispose();
    _signupPassController.dispose();
    _loginEmailController.dispose();
    _loginPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: _itemCount,

                controller: _pageController,

                itemBuilder: (context, index) {
                  return IntroPageItem(
                    imagePath: "assets/images/intro_img1.png",
                    heading: "Select the Favorities\nMenu",
                    description:
                        "Now eat well, don't leave the house,You\ncan"
                        "choose your favorite food only with",
                    onPressed: () => _pageController.nextPage(
                      duration: Duration(microseconds: 500),
                    
                      curve: Curves.linearToEaseOut,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                // Note : you are  calling widget twice intead wraping the parent  row widget with padding:
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //! padding is used here :
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 16.0),
                  //   child:
                  TextButton(
                    onPressed: () {
                      _pageController.jumpToPage(_itemCount - 1);
                    },
                    child: TextViewNormal(
                      text: "skip",
                      colors: AppColors.blackColor,
                    ),
                  ),
                  // ),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: _itemCount,
                    effect: SwapEffect(
                      activeDotColor: AppColors.orangeColor,
                      dotHeight: 10,
                      dotWidth: 10,
                      dotColor: AppColors.lightGrey,
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      if (_pageController.page!.round() > _itemCount - 1) {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.linearToEaseOut,
                        );
                      } else {
                        Navigator.popAndPushNamed(context, AppRoutes.loginPage);
                      }
                    },
                    icon:
                        //  Padding(
                        //                   //! padding is used here :
                        //   padding: const EdgeInsets.only(right: 16.0),
                        //   child:
                        Icon(Icons.arrow_forward, color: AppColors.orangeColor),

                    // ),
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

//! Why not make it a widget ?

//! why its a function  not a widget ?
