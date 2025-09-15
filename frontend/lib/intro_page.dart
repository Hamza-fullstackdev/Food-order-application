import 'package:flutter/material.dart';
import 'package:frontend/homeScreen.dart';
import 'package:frontend/utils/app_contants.dart';
import 'package:frontend/utils/text_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with TickerProviderStateMixin {
  late PageController _controller;
  late TabController _tabController;
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passController;
  late int _itemCount;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _controller = PageController();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passController = TextEditingController();
    _itemCount = 3;
    super.initState();
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
                child: PageView(
                  controller: _controller,
                  children: [
                    PageItem(
                      "assets/images/intro_img1.png",
                      "Select the\nFavorities Menu",
                      "Now eat well, don't leave the house,You can\n" "choose your favorite food only with\n",
                    ),

                    PageItem(
                      "assets/images/intro_img2.png",
                      "Good food at a\ncheap price",
                      "You can eat at expensive\nrestaurants with\n" "affordable price",
                    ),

                    PageItem(
                      "assets/images/intro_img1.png",
                      "Select the\nFavorities Menu",
                      "Now eat well, don't leave the house,You can\n" "choose your favorite food only with\n",
                    ),
                  ],
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
                        if (_controller.page!.round() > _itemCount - 1) {
                          _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.linearToEaseOut,
                          );
                        } else {
                          showBottomSheet(
                            showDragHandle: true,
                            enableDrag: true,
                            backgroundColor: AppContants.whiteColor,
                            elevation: 5,
                            context: context,
                            builder: (context) => SizedBox(
                              height: 400,
                              child: DefaultTabController(
                                length: 2,
                                child: Column(
                                  children: [
                                    TabBar(
                                      tabs: [
                                        Tab(
                                          child: TextView(
                                            text: "Create Account",
                                          ),
                                        ),
                                        Tab(child: TextView(text: "Login")),
                                      ],
                                    ),
                                    Expanded(
                                      child: TabBarView(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 4.0,
                                                        horizontal: 14,
                                                      ),
                                                  child: TextView(
                                                    text: "First Name",
                                                    size: 14,
                                                    weight: 500,
                                                  ),
                                                ),
                                                TextFormField(
                                                  controller: _nameController,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    hint: TextView(
                                                      text: "Enter you name",
                                                      size: 14,
                                                      weight: 500,
                                                    ),

                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                7,
                                                              ),
                                                          borderSide: BorderSide(
                                                            color: AppContants
                                                                .offWhiteColor,
                                                          ),
                                                        ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                7,
                                                              ),
                                                          borderSide: BorderSide(
                                                            color: AppContants
                                                                .offWhiteColor,
                                                          ),
                                                        ),
                                                    errorBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            7,
                                                          ),
                                                      borderSide: BorderSide(
                                                        color: AppContants
                                                            .redColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 4.0,
                                                        horizontal: 14,
                                                      ),
                                                  child: TextView(
                                                    text: "Email",
                                                    size: 14,
                                                    weight: 500,
                                                  ),
                                                ),
                                                TextFormField(
                                                  controller: _emailController,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    hint: TextView(
                                                      text: "Enter your email",
                                                      size: 14,
                                                      weight: 500,
                                                    ),

                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                7,
                                                              ),
                                                          borderSide: BorderSide(
                                                            color: AppContants
                                                                .offWhiteColor,
                                                          ),
                                                        ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                7,
                                                              ),
                                                          borderSide: BorderSide(
                                                            color: AppContants
                                                                .offWhiteColor,
                                                          ),
                                                        ),
                                                    errorBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            7,
                                                          ),
                                                      borderSide: BorderSide(
                                                        color: AppContants
                                                            .redColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 4.0,
                                                        horizontal: 14,
                                                      ),
                                                  child: TextView(
                                                    text: "Password",
                                                    size: 14,
                                                    weight: 500,
                                                  ),
                                                ),
                                                TextFormField(
                                                  controller: _passController,
                                                  obscureText: true,
                                                  obscuringCharacter: "*",
                                                  decoration: InputDecoration(
                                                    hint: TextView(
                                                      text:
                                                          "Enter your password",
                                                      size: 14,
                                                      weight: 500,
                                                    ),

                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                7,
                                                              ),
                                                          borderSide: BorderSide(
                                                            color: AppContants
                                                                .offWhiteColor,
                                                          ),
                                                        ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                7,
                                                              ),
                                                          borderSide: BorderSide(
                                                            color: AppContants
                                                                .offWhiteColor,
                                                          ),
                                                        ),
                                                    errorBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            7,
                                                          ),
                                                      borderSide: BorderSide(
                                                        color: AppContants
                                                            .redColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
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

  Column PageItem(imgResource, pageHeading, pageDescription) {
    return Column(
      children: [
        Image.asset(imgResource, height: 334, width: 308),
        TextView(
          text: "Select the\nFavorities Menu",
          textAlignment: true,
          size: 22,
          weight: 700,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: TextView(
            text:
                "Now eat well, don't leave the house,You can\n" "choose your favorite food only with\n" "one click",
            textAlignment: true,
            size: 12,
            weight: 400,
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: LinearGradient(
              colors: [Color(0xffD61355), Color(0xffFF0000)],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 48),
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
}
