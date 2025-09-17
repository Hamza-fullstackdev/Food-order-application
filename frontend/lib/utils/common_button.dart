import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/utils/app_contants.dart';

class CommonButton extends StatelessWidget{
  final Widget child ;
  final color ;
  final isGradient ;
  
  final VoidCallback onPressed;
  const CommonButton({super.key,required this.onPressed,this.isGradient = false,this.color = AppContants.offWhiteColor,required this.child});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: !isGradient ? color : null,
        gradient: isGradient ? LinearGradient(colors:[
           Color(0xffD61355),
           Color(0xffFF0000)
        ]) : null
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 48),
        child: child),
        ),
    );
  }
}