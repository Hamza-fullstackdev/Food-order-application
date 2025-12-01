// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:frontend/MVVM/ViewModel/auth_provider.dart';
import 'package:frontend/MVVM/views/edit_text.dart';
import 'package:frontend/Resources/app_colors.dart';
import 'package:frontend/Resources/app_messeges.dart';
import 'package:frontend/Resources/app_routes.dart';
import 'package:frontend/Resources/assetsPath.dart';
import 'package:frontend/Resources/status.dart';
import 'package:frontend/Widgets/common_button.dart';
import 'package:frontend/Widgets/text_view.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  bool _obsecureText = false;

  late final TextEditingController _emailController;
  late final TextEditingController _passController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late bool _rememberMe;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passController = TextEditingController();

    _rememberMe = false;
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  Image.asset(AssetsPath.decorationImg2),
                  Positioned(
                    bottom: 70.0,
                    width: MediaQuery.of(context).size.width,

                    child: Column(
                      children: [
                        Center(
                          child: TextViewNormal(
                            isBold: true,
                            size: 30,
                            text: "Log In",
                            colors: AppColors.whiteColor,
                          ),
                        ),
                        SizedBox(height: 5),
                        TextViewNormal(
                          text: "Please sign in to your existing account",
                          // ignore: deprecated_member_use
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

              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.65,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),

                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextViewNormal(
                          text: 'Email',
                          colors: AppColors.lightBlackColor,
                        ),
                        SizedBox(height: 5),
                        EditTextForm(
                          controller: _emailController,
                          hintMessage: 'enter email here...',
                          errorMessage: "Email should not be empty",
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 10),

                        TextViewNormal(text: 'Password'),
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
                                  _obsecureText = !_obsecureText;
                              });
                            },
                            icon: _obsecureText
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            color: AppColors.darkGreyColor,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  checkColor: AppColors.orangeColor,

                                  value: _rememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      _rememberMe = !_rememberMe;
                                    });
                                  },
                                ),
                                TextViewNormal(text: "Remember me", size: 12),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.forgetPassword,
                                );
                              },
                              child: TextViewNormal(
                                text: "Forgot Password",
                                size: 12,
                                colors: AppColors.orangeColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Consumer<AuthProvider>(
                          builder: (context, value, child) =>
                              ButtonContainerFilled(
                                height: 54,
                                width: MediaQuery.of(context).size.width,
                                function: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await value.loginUser(
                                      _emailController.text,
                                      _passController.text,
                                    );
                                  }
                                  if (!mounted) return;

                                  if (value.loginResponse.status ==
                                      ResponseStatus.success) {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.bottomSheet,
                                    );
                                  } else if (value.loginResponse.status ==
                                      ResponseStatus.failed) {
                                    MessageUtils.showSnackBar(
                                      context,
                                      value.loginResponse.message!,
                                    );
                                  }
                                },
                                child:
                                    value.loginResponse.status ==
                                        ResponseStatus.loading
                                    ? CircularProgressIndicator()
                                    : TextViewNormal(
                                        text: "Login",
                                        size: 14,
                                        isBold: true,
                                        colors: AppColors.whiteColor,
                                      ),
                              ),
                        ),
                        SizedBox(height: 25),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextViewNormal(
                              text: 'Don’t have an account?',
                              size: 12,
                              colors: AppColors.darkGreyColor,
                            ),
                            SizedBox(width: 5),
                            InkWell(
                              onTap: () {
                                Navigator.of(
                                  context,
                                ).pushNamed(AppRoutes.signupPage);
                              },
                              child: TextViewNormal(
                                text: 'SIGN UP',
                                size: 12,
                                isBold: true,
                                colors: AppColors.orangeColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Center(
                          child: TextViewNormal(
                            text: 'Or',
                            size: 14,
                            // ignore: deprecated_member_use
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
            ),
          ],
        ),
      ),
    );
  }
}
