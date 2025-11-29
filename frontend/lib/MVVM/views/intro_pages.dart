import 'package:flutter/material.dart';
import 'package:frontend/Resources/app_colors.dart';
import 'package:frontend/Resources/app_routes.dart';
import 'package:frontend/Widgets/common_button.dart';
import 'package:frontend/Widgets/text_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with TickerProviderStateMixin {
  late PageController _controller;
  late final TextEditingController _nameController;
  late final TextEditingController _signupEmailController;
  late final TextEditingController _signupPassController;

  late final TextEditingController _loginEmailController;
  late final TextEditingController _loginPassController;
  late int _itemCount;

  @override
  void initState() {
    _controller = PageController();
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
    _controller.dispose();
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
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.blackColor,
                  image: DecorationImage(
                    image: AssetImage("assets/images/on_board_bg.png"),
                  ),
                ),
              ),
              Expanded(
                child: Builder(
                  builder: (context) {
                    return PageView(
                      controller: _controller,
                      children: [
                        pageItem(
                          "assets/images/intro_img1.png",
                          "Select the Favorities Menu",
                          "Now eat well, don't leave the house,You can"
                              "choose your favorite food only with",
                          () => _controller.nextPage(
                            duration: Duration(microseconds: 500),
                            curve: Curves.linearToEaseOut,
                          ),
                        ),

                        pageItem(
                          "assets/images/intro_img2.png",
                          "Good food at a\ncheap price",
                          "You can eat at expensive\nrestaurants with\n"
                              "affordable price",
                          () => _controller.nextPage(
                            duration: Duration(microseconds: 500),
                            curve: Curves.linearToEaseOut,
                          ),
                        ),

                        pageItem(
                          "assets/images/intro_img1.png",
                          "Select the\nFavorities Menu",
                          "Now eat well, don't leave the house,You can\n"
                              "choose your favorite food only with\n",
                          () => Navigator.popAndPushNamed(
                            context,
                            AppRoutes.loginPage,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          Container(
            alignment: AlignmentGeometry.xy(0, 0.95),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: TextButton(
                    onPressed: () {
                      _controller.jumpToPage(_itemCount - 1);
                    },
                    child: TextViewNormal(
                      text: "skip",
                      colors: AppColors.blackColor,
                    ),
                  ),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: _itemCount,
                  effect: SwapEffect(
                    activeDotColor: AppColors.orangeColor,
                    dotHeight: 10,
                    dotWidth: 10,
                    dotColor: AppColors.lightGrey,
                  ),
                ),

                Builder(
                  builder: (context) {
                    return IconButton(
                      onPressed: () {
                        if (_controller.page!.round() > _itemCount - 1) {
                          _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.linearToEaseOut,
                          );
                        } else {
                          Navigator.popAndPushNamed(context, AppRoutes.loginPage);
                        }
                      },
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Icon(
                          Icons.arrow_forward,
                          color: AppColors.orangeColor,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Column pageItem(
  final String imgResource,
  final String pageHeading,
  final String pageDescription,
  VoidCallback onPressed,
) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 56),
        child: Image.asset(imgResource, height: 334, width: 308),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 40, left: 66, right: 66),
        child: Text(
          pageHeading,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20, right: 40, left: 40),
        child: Text(
          pageDescription,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w300),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 42),
        child: ButtonContainerFilled(
          height: 57,
          width: 157,
          function: onPressed,
          child: Text(
          'Next',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(fontSize: 16,color: AppColors.offWhiteColor, fontWeight: FontWeight.w700),
        ),
        ),
      ),
    ],
  );
}
