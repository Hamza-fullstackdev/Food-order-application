import 'package:flutter/material.dart';
import 'package:frontend/utils/app_contants.dart';
import 'package:frontend/utils/text_view.dart';

class Buttons extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(colors:[
           Color(0xffD61355),
           Color(0xffFF0000)
        ])
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 48),
        child: TextView(text: "Next",color: AppContants.whiteColor,textAlignment: true,),
      ),
    );
  }
}