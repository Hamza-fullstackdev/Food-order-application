import 'package:flutter/material.dart';
import 'package:frontend/utils/app_contants.dart';

class TextView extends StatelessWidget{
  final String text;
  final color;
  final double size;
  final bool bold;

  const TextView({super.key,required this.text, this.color = AppContants.blackColor,this.bold = false,this.size = 18});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal 
      ),
    );
  }
}