import 'package:flutter/material.dart';
import 'package:frontend/utils/app_contants.dart';

class TextView extends StatelessWidget{
  final String text;
  final color;
  final double size;
  final bool bold;
  final bool textAlignment;

  const TextView({super.key,required this.text,
   this.color = AppContants.blackColor
  ,this.bold = false,
  this.size = 18,
  this.textAlignment = false});
  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlignment ? TextAlign.center : TextAlign.start,
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal 
      ),
    );
  }
}