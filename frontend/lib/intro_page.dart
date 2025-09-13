import 'package:flutter/material.dart';
import 'package:frontend/utils/app_contants.dart';
import 'package:frontend/utils/buttons.dart';
import 'package:frontend/utils/text_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroPage extends StatelessWidget {
  final PageController _controller = PageController();
  final int _itemCount = 3;

  IntroPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //! bandra jaya sari kali screen i ja rai c Scaffold ch ta wrape  kr ly 😂😂😁
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
                  children: [NewWidget(), NewWidget(), NewWidget()],
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
                  onPressed: () {},
                  child: TextView(text: "skip", color: AppContants.redColor),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: _itemCount,
                  effect: SwapEffect(
                    activeDotColor: AppContants.redColor,
                    dotColor: AppContants.greyColor.withOpacity(.15),

                    dotHeight: 10,
                    dotWidth: 10,
                    // dotColor: AppContants.offWhiteColor,
                  ),
                ),

                TextButton(
                  style: TextButton.styleFrom(),
                  onPressed: () {},
                  child: TextView(text: "Next", color: AppContants.redColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/images/intro_img1.png",
          height: 334,
          width: double.infinity,
        ),
        TextView(
          text: "Select the\nFavorities Menu",
          textAlignment: true,
          size: 22,
          bold: true,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: TextView(
            text:
                "Now eat well, don't leave the house,You can\n"
                    "choose your favorite food only with\n" +
                "one click",
            textAlignment: true,
            size: 18,
            bold: false,
          ),
        ),
        Buttons(),
      ],
    );
  }
}
