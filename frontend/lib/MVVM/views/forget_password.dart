import 'package:flutter/material.dart';
import 'package:frontend/MVVM/views/edit_text.dart';
import 'package:frontend/Resources/app_colors.dart';
import 'package:frontend/Resources/app_routes.dart';
import 'package:frontend/Resources/assetsPath.dart';
import 'package:frontend/Widgets/common_button.dart';
import 'package:frontend/Widgets/text_view.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});
  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
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
                  Image.asset(AssetsPath.decorationImg2),
                  Padding(
                    padding: const EdgeInsets.only(top: 48,left: 16),
                    child: CircleAvatar(
                      backgroundColor: AppColors.lightGreyColor2,
                      radius: 25,
                      child: IconButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, icon: Icon(Icons.arrow_back_ios_new,color: AppColors.blackColor,)),
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
                            text: "Forgot Password",
                            colors: AppColors.whiteColor,
                          ),
                        ),
                        SizedBox(height: 5,),
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
                      SizedBox(height: 20),
                      ButtonContainerFilled(
                        height: 54,
                        width: MediaQuery.of(context).size.width,
                        function: () =>
                            Navigator.popAndPushNamed(context, AppRoutes.verificationPage),
                        child: TextViewNormal(
                          text: "Send Code",
                          size: 14,
                          isBold: true,
                          colors: AppColors.whiteColor,
                        ),
                      ),
                      SizedBox(height: 25),
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