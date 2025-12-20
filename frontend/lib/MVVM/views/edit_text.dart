import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/Resources/app_colors.dart';

class EditTextForm extends StatelessWidget {
  final String errorMessage;
  final String hintMessage;
  final String passError;
  final String confirmPassError;
  final TextEditingController controller;
  final TextEditingController? passController;
  final IconButton? icon;
  final TextInputType keyboardType;
  final bool isCapital;
  final bool isConfirmPass;
  final bool isPassword;
  const EditTextForm({
    super.key,
    required this.hintMessage,
    required this.controller,
    this.passController,
    this.icon,
    required this.errorMessage,
    required this.keyboardType,
    this.confirmPassError = "Password does not matched...",
    this.passError = "Password should be at least of 6 length",
    this.isPassword = false,
    this.isCapital = true,
    this.isConfirmPass = false,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorMessage;
        }
        if (isPassword && value.length < 6) {
          return passError;
        }
        if (isConfirmPass && value != passController!.text) {
          return confirmPassError;
        }
        return null;
      },
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      obscureText: isPassword,
      obscuringCharacter: '*',

      textCapitalization: isCapital
          ? TextCapitalization.sentences
          : TextCapitalization.none,
      decoration: InputDecoration(
        suffixIcon: icon,
        hintText: hintMessage,
        hintStyle: TextStyle(color: AppColors.darkGreyColor),
        filled: true,
        fillColor: AppColors.lightGreyColor2,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class EditTextNormal extends StatelessWidget {
  final bool suffix;
  final bool prefix;
  final Icon? icon;
  final TextInputFormatter? inputFormatter;
  final TextInputType? keyboardType;
  final int? maxLength;
  final bool isHide;
  final String hintMessage;
  final TextEditingController controller;

  const EditTextNormal({
    super.key,
    required this.hintMessage,
    required this.controller,
    this.isHide = false,
    this.suffix = false,
    this.prefix = false,
    this.icon,
    this.maxLength,
    this.inputFormatter,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      inputFormatters: inputFormatter != null ? [inputFormatter!] : [],
      maxLength: maxLength,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.none,
      obscureText: isHide,
      decoration: InputDecoration(
        suffixIcon: suffix ? icon : null,
        prefixIcon: prefix ? icon : null,
        contentPadding: const EdgeInsets.all(10),
        hintText: hintMessage,
        hintStyle: TextStyle(color: AppColors.darkGreyColor),
        filled: true,
        fillColor: AppColors.lightGreyColor2,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class EditTextCardForm extends StatelessWidget {
  final String hintMessage;
  final String errorMessage;
  final TextEditingController controller;

  const EditTextCardForm({
    super.key,
    required this.hintMessage,
    required this.controller,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintMessage,
        hintStyle: TextStyle(color: AppColors.darkGreyColor),
        filled: true,
        fillColor: AppColors.lightGreyColor2,
        counterText: "",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.orangeColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
