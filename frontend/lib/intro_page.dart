import 'package:flutter/material.dart';
import 'package:frontend/helper_classes/tab_view.dart';
import 'package:frontend/utils/app_contants.dart';
import 'package:frontend/utils/common_button.dart';
import 'package:frontend/utils/text_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with TickerProviderStateMixin {
  late PageController _controller;
  late final TabController _tabController;
  late final TextEditingController _nameController;
  late final TextEditingController _signupEmailController;
  late final TextEditingController _signupPassController;

  late final TextEditingController _loginEmailController;
  late final TextEditingController _loginPassController;
  late int _itemCount;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
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
                  color: AppContants.blackColor,
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
                          "Select the\nFavorities Menu",
                          "Now eat well, don't leave the house,You can\n"
                              "choose your favorite food only with\n",
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
                          () => presistanceBottomSheet(context),
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    _controller.jumpToPage(_itemCount - 1);
                  },
                  child: TextView(text: "skip", color: AppContants.blackColor),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: _itemCount,
                  effect: SwapEffect(
                    activeDotColor: AppContants.redColor,
                    dotHeight: 10,
                    dotWidth: 10,
                    dotColor: AppContants.lightGrey,
                  ),
                ),

                Builder(
                  builder: (context) {
                    return IconButton(
                      onPressed: () {
                        if (_controller.page!.round() < _itemCount - 1) {
                          _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.linearToEaseOut,
                          );
                        } else {
                          presistanceBottomSheet(context);
                        }
                      },
                      icon: Icon(
                        Icons.arrow_forward,
                        color: AppContants.redColor,
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

  PersistentBottomSheetController presistanceBottomSheet(BuildContext context) {
    return showBottomSheet(
      showDragHandle: true,
      enableDrag: true,

      backgroundColor: AppContants.whiteColor,
      elevation: 5,
      context: context,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: DefaultTabController(
          length: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TabBar(
                controller: _tabController,
                labelColor: AppContants.redColor,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppContants.blackColor,
                  fontSize: 16,
                ),
                indicatorColor: AppContants.redColor,
                indicatorWeight: 1.0,
                tabs: [
                  Tab(text: "Create Account"),
                  Tab(text: "Login"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: SingleChildScrollView(
                        child: TabView(
                          nameController: _nameController,
                          emailController: _signupEmailController,
                          passController: _signupPassController,
                          tabController: _tabController,
                          login: false,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),

                      child: SingleChildScrollView(
                        child: TabView(
                          emailController: _loginEmailController,
                          passController: _loginPassController,
                          tabController: _tabController,
                          login: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Column pageItem(
  imgResource,
  pageHeading,
  pageDescription,
  VoidCallback onPressed,
) {
  return Column(
    children: [
      Image.asset(imgResource, height: 334, width: 308),
      TextView(text: pageHeading, textAlignment: true, size: 22, weight: 700),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: TextView(
          text: pageDescription,
          textAlignment: true,
          size: 12,
          weight: 400,
        ),
      ),
      CommonButton(
        onPressed: onPressed,
        isGradient: true,
        child: TextView(
          text: "Next",
          size: 16,
          weight: 900,
          color: AppContants.whiteColor,
          textAlignment: true,
        ),
      ),
    ],
  );
}
