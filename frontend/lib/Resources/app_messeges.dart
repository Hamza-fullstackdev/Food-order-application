// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/Resources/app_colors.dart';

class MessageUtils {
  
  static void showToast(
    String message, {
    ToastGravity gravity = ToastGravity.BOTTOM,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
    int durationInSeconds = 2,
  }) {
    Fluttertoast.showToast(
      msg: message,
      gravity: gravity,
      backgroundColor: backgroundColor,
      textColor: textColor,
      toastLength: durationInSeconds == 2
          ? Toast.LENGTH_SHORT
          : Toast.LENGTH_LONG,
    );
  }

  static void showSnackBar(
    BuildContext context,
    String message, {
    final backgroundColor = AppColors.darkBlack,
    int durationInSeconds = 2,
  }) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.symmetric(vertical: 24,horizontal: 16),
      dismissDirection: DismissDirection.horizontal,
      content: Text(message,style: TextStyle(color: AppColors.dartWhiteColor),),
      backgroundColor: backgroundColor,
      duration: Duration(seconds: durationInSeconds),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showMaterialBanner(
    BuildContext context,
    String message, {
    Color backgroundColor = AppColors.darkBlack,
    int durationInSeconds = 3,
  }) {
    final banner = MaterialBanner(
      content: Text(message,style: TextStyle(color: AppColors.whiteColor),),
      backgroundColor: backgroundColor,
      actions: [
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          },
          child: const Text("DISMISS", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(banner);
    Future.delayed(Duration(seconds: durationInSeconds), () {
      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    });
  }

  static void showDialogMessage(
    BuildContext context,
    String title,
    String message,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
