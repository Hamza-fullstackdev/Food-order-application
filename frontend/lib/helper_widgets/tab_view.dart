// ignore: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/Repos/auth_provider.dart';
import 'package:frontend/homeScreen.dart';
import 'package:frontend/utils/app_contants.dart';
import 'package:frontend/utils/common_button.dart';
import 'package:frontend/utils/text_view.dart';
import 'package:provider/provider.dart';

class TabView extends StatelessWidget {
  final TextEditingController? nameController;
  final TextEditingController emailController;
  final TextEditingController passController;
  final TabController tabController;

  final bool login;
  final _formKey = GlobalKey<FormState>();

  TabView({
    super.key,
    required this.emailController,
    required this.passController,
    required this.tabController,
    this.nameController,
    required this.login,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!login)
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 14,
                ),
                child: TextView(text: "First Name", size: 14, weight: 500),
              ),
            if (!login)
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "User name required.";
                  }
                  return null;
                },
                controller: nameController,
                obscureText: false,
                decoration: InputDecoration(
                  hint: TextView(text: "Enter you name", size: 14, weight: 500),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide(color: AppContants.offWhiteColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide(color: AppContants.offWhiteColor),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide(color: AppContants.redColor),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 14,
              ),
              child: TextView(text: "Email address", size: 14, weight: 500),
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "User name required.";
                }
                return null;
              },
              controller: emailController,
              obscureText: false,
              decoration: InputDecoration(
                hint: TextView(text: "Enter your email", size: 14, weight: 500),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(color: AppContants.offWhiteColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(color: AppContants.offWhiteColor),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(color: AppContants.redColor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 14,
              ),
              child: TextView(text: "Password", size: 14, weight: 500),
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "User password required.";
                }
                return null;
              },
              controller: passController,
              obscureText: true,
              obscuringCharacter: "*",
              decoration: InputDecoration(
                hint: TextView(
                  text: "Enter your password",
                  size: 14,
                  weight: 500,
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(color: AppContants.offWhiteColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(color: AppContants.offWhiteColor),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(color: AppContants.redColor),
                ),
              ),
            ),
            if (login)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffFF0000),
                      ),
                    ),
                  ),
                ],
              ),

            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: CommonButton(
                  height: 53,
                  width: 256,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      //  _emailController.clear();
                      // _passController.clear();
                      // _nameController!.clear();
                      bool isLogin = login ? await authProvider.loginUser(
                        emailController.text,
                        passController.text,
                        true,
                      ) : await authProvider.loginUser(
                                emailController.text,
                                passController.text,
                                false,
                                userName: nameController!.text,
                              );
                      if (isLogin) {
                        login ? 
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MyHomePage(title: "Hello world"),
                          ),
                        ): tabController.animateTo(1) ;
                      }
                    }
                  },
                  isGradient: true,
                  child: login
                      ? TextView(
                          text: "Login",
                          size: 14,
                          weight: 900,
                          color: AppContants.whiteColor,
                          textAlignment: true,
                        )
                      : TextView(
                        text: "Sign Up",
                        size: 14,
                        weight: 900,
                        color: AppContants.whiteColor,
                        textAlignment: true,
                      ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 148.0),
              child: Divider(thickness: 1),
            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: CommonButton(
                  height: 53,
                  width: 256,
                  onPressed: () {},
                  isGradient: false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image(image: AssetImage("assets/images/ic_google.png")),
                      SizedBox(width: 20),
                      TextView(
                        text: "Sign up with Google",
                        size: 14,
                        weight: 700,
                        color: AppContants.blackColor,
                        textAlignment: true,
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
