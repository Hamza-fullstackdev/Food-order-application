import 'package:flutter/material.dart';
import 'package:frontend/utils/app_contants.dart';
import 'package:google_fonts/google_fonts.dart';

class TextView extends StatelessWidget {
  final String text;
  final color;
  final double size;
  final int weight;
  final bool textAlignment;

  const TextView({super.key,required this.text,
   this.color = AppContants.blackColor,
   this.weight = 300,
  this.size = 18,
  this.textAlignment = false});
  @override
  Widget build(BuildContext context) {
    return Text(
      
      textAlign: textAlignment ? TextAlign.center : TextAlign.start,
      text,
      style: GoogleFonts.poppins(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.values[weight ~/100 - 1]
      ),
    );
  }
}
