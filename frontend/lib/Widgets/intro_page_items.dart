import 'package:flutter/material.dart';
import 'package:frontend/Resources/app_colors.dart';
import 'package:frontend/Widgets/common_button.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPageItem extends StatelessWidget {
  final String imagePath;
  final String heading;
  final String description;
  final VoidCallback onPressed;

  const IntroPageItem({
    super.key,
    required this.imagePath,
    required this.heading,
    required this.description,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 56),
          child: Image.asset(imagePath, height: 334, width: 308),
        ),
        SizedBox(height: 30),
        Text(
          heading,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 20),

        Text(
          description,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 42),

        ButtonContainerFilled(
          height: 57,
          width: 157,
          function: onPressed,
          child: Text(
            'Next',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: AppColors.offWhiteColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
