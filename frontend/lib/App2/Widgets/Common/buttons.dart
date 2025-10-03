import 'package:flutter/material.dart';
import 'package:frontend/App/MVVM/views/productScreen.dart';
import 'package:frontend/App2/Widgets/Common/app_contants.dart';
import 'package:frontend/App2/Widgets/Common/text_view.dart';

class Buttons extends StatelessWidget {
  const Buttons({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductScreen()),
        );
      },
      child: Container(
        height: 63,
        width: 157,
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
            color: AppContants.whiteColor,
            textAlignment: true,
          ),
        ),
      ),
    );
  }
}
