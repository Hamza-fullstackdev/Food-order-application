import 'package:flutter/material.dart';
import 'package:frontend/Resources/app_colors.dart';

class ButtonContainerFilled extends StatelessWidget {
  final Widget child;
  final VoidCallback function;
  final double height;
  final double width;
  final Color color;
  const ButtonContainerFilled({
    super.key,
    required this.function,
    required this.child,
    this.color = AppColors.orangeColor,
    this.height = 54,
    this.width = 50,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width, height),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: AppColors.blackColor, width: 0.1),
        ),
      ),
      child: child,
    );
  }
}

class ButtonContainerNormal extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final Widget child;
  final VoidCallback function;
  const ButtonContainerNormal({
    super.key,
    required this.child,
    required this.function,
    this.height = 57,
    this.width = 57,
    this.color = AppColors.whiteColor,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(width, height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: color, width: 0.1),
          ),
        ),
        child: child,
      ),
    );
  }
}