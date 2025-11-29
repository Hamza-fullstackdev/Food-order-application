import 'package:flutter/material.dart';
import 'package:frontend/Resources/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class TextViewNormal extends StatelessWidget {
  final bool isBold;
  final String text;
  final Color colors;
  final double size;
  final TextAlign ? align;
  const TextViewNormal({
    super.key,
    required this.text,
    this.align,
    this.colors = AppColors.blackColor,
    this.isBold = false,
    this.size = 16,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: true,
      overflow: TextOverflow.visible,
      maxLines: null,
      textAlign: align,
      style: GoogleFonts.poppins(
        color: colors,
        fontSize: size,
        fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
      ),
    );
  }
}

class TextViewLarge extends StatelessWidget {
  final bool isBold;
  final String text;
  final Color colors;
  final double size;
  final TextAlign ? align;
  const TextViewLarge({
    super.key,
    required this.text,
    this.align,
    this.colors = AppColors.blackColor,
    this.isBold = true,
    this.size = 24,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: GoogleFonts.poppins(
        color: colors,
        fontSize: size,
        fontWeight: isBold ? FontWeight.w900 : FontWeight.normal,
      ),
    );
  }
}