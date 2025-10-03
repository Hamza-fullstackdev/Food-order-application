import 'package:flutter/material.dart';
import 'package:frontend/App2/Data/Responses/status.dart';
import 'package:frontend/App2/MVVM/ViewModel/auth_provider.dart';
import 'package:frontend/App2/MVVM/Views/homeScreen.dart';
import 'package:frontend/App2/Widgets/tab_view.dart';
import 'package:frontend/App2/Widgets/Common/app_contants.dart';
import 'package:frontend/App2/Widgets/Common/common_button.dart';
import 'package:frontend/App2/Widgets/Common/text_view.dart';
import 'package:provider/provider.dart';
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
      body: Consumer<AuthProvider>(
        builder: (context, value, child) {
          // ignore: unrelated_type_equality_checks
          if (value.apiResponse.status == Status.Success) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MyHomePage(title: "Hello world"),
              ),
            );
            return Text('');
          } else if (value.apiResponse.status == Status.Error) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SafeArea(
                child: Text(
                  "${value.apiResponse.message}",
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else if (value.apiResponse.status == Status.Loading) {
            return CircularProgressIndicator();
          } else {
            return Stack(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: TextButton(
                          onPressed: () {
                            _controller.jumpToPage(_itemCount - 1);
                          },
                          child: TextView(
                            text: "skip",
                            color: AppContants.blackColor,
                          ),
                        ),
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
                              if (_controller.page!.round() > _itemCount - 1) {
                                _controller.nextPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.linearToEaseOut,
                                );
                              } else {
                                presistanceBottomSheet(context);
                              }
                            },
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Icon(
                                Icons.arrow_forward,
                                color: AppContants.redColor,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
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
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.75,
        minChildSize: 0.40,
        maxChildSize: 0.90,
        builder: (context, scrollController) {
          return SizedBox(
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
          );
        },
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
      Padding(
        padding: const EdgeInsets.only(top: 56),
        child: Image.asset(imgResource, height: 334, width: 308),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 40, left: 66, right: 66),
        child: TextView(
          text: pageHeading,
          textAlignment: true,
          size: 22,
          weight: 700,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20, right: 40, left: 40),
        child: TextView(
          text: pageDescription,
          textAlignment: true,
          size: 14,
          weight: 400,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 42),
        child: CommonButton(
          height: 57,
          width: 157,
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
      ),
    ],
  );
}
