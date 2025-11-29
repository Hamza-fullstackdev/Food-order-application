// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:frontend/MVVM/views/edit_text.dart';
import 'package:frontend/Resources/app_colors.dart';
import 'package:frontend/Widgets/common_button.dart';
import 'package:frontend/Widgets/text_view.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupScreen> {
  bool _obsecureText = false, _obsecureTextC = false;
  late final TextEditingController _emailController;
  late final TextEditingController _passController;

  late final TextEditingController _nameController;

  late final TextEditingController _confirmController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passController = TextEditingController();

    _nameController = TextEditingController();
    _confirmController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();

    _nameController.dispose();
    _passController.dispose();
    _confirmController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              color: AppColors.blackColor,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.38,
              child: Stack(
                children: [
                  Image.asset('assets/images/circle_img2.png'),
                  Padding(
                    padding: const EdgeInsets.only(top: 48, left: 16),
                    child: CircleAvatar(
                      backgroundColor: AppColors.blackColor.withOpacity(0.7),
                      radius: 25,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 70.0,
                    width: MediaQuery.of(context).size.width,

                    child: Column(
                      children: [
                        Center(
                          child: TextViewNormal(
                            isBold: true,
                            size: 30,
                            text: "Sign Up",
                            colors: AppColors.whiteColor,
                          ),
                        ),
                        SizedBox(height: 5),
                        TextViewNormal(
                          text: "Please sign up to get started",
                          colors: AppColors.whiteColor.withOpacity(0.7),
                          align: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,

              child: Container(
                height: MediaQuery.of(context).size.height * 0.65,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                  top: 32,
                  bottom: 16,
                  left: 16,
                  right: 16,
                ),

                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextViewNormal(
                        text: 'Name',
                        colors: AppColors.blackColor.withOpacity(0.7),
                      ),
                      SizedBox(height: 5),
                      EditTextForm(
                        controller: _nameController,
                        hintMessage: 'enter name here...',
                        errorMessage: "Email should not be empty",
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 10),
                      TextViewNormal(
                        text: 'Email',
                        colors: AppColors.blackColor.withOpacity(0.7),
                      ),
                      SizedBox(height: 5),
                      EditTextForm(
                        controller: _emailController,
                        hintMessage: 'enter email here...',
                        errorMessage: "Email should not be empty",
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 10),

                      TextViewNormal(
                        text: 'Password',
                        colors: AppColors.blackColor.withOpacity(0.7),
                      ),
                      SizedBox(height: 5),
                      EditTextForm(
                        hintMessage: 'enter password here...',
                        controller: _passController,
                        isPassword: _obsecureText,
                        errorMessage: "Password should not be empty",
                        keyboardType: TextInputType.text,
                        icon: IconButton(
                          onPressed: () {
                            setState(() {
                              if (_passController.text.isNotEmpty)
                                {_obsecureText = !_obsecureText;}
                            });
                          },
                          icon: _obsecureText
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          color: AppColors.blackColor.withOpacity(0.7),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextViewNormal(
                        text: 'Confirm Password',
                        colors: AppColors.blackColor.withOpacity(0.7),
                      ),
                      SizedBox(height: 5),
                      EditTextForm(
                        hintMessage: 're-enter password here...',
                        controller: _confirmController,
                        passController: _passController,
                        isPassword: _obsecureTextC,
                        errorMessage: "confirmation should not be empty",

                        icon: IconButton(
                          onPressed: () {
                            setState(() {
                              if (_confirmController.text.isNotEmpty)
                                {_obsecureTextC = !_obsecureTextC;}
                            });
                          },
                          icon: _obsecureTextC
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          color: AppColors.blackColor.withOpacity(0.7),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 20),
                      ButtonContainerFilled(
                        height: 54,
                        width: MediaQuery.of(context).size.width,
                        function: () => Navigator.of(context).pop(),
                        child: TextViewNormal(
                          text: "Sign Up",
                          size: 14,
                          isBold: true,
                          colors: AppColors.whiteColor,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(height: 25),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextViewNormal(
                            text: 'Already have an account?',
                            size: 12,
                            colors: AppColors.blackColor.withOpacity(0.7),
                          ),
                          SizedBox(width: 5),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: TextViewNormal(
                              text: 'LOG IN',
                              size: 12,
                              isBold: true,
                              colors: AppColors.orangeColor.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Center(
                        child: TextViewNormal(
                          text: 'Or',
                          size: 14,
                          colors: AppColors.blackColor.withOpacity(0.50),
                        ),
                      ),
                      SizedBox(height: 15),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.blueAccent,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.facebook,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          CircleAvatar(
                            radius: 20,

                            backgroundColor: Colors.blue,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.adobe_sharp,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          CircleAvatar(
                            radius: 20,

                            backgroundColor: Colors.black,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.facebook,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}