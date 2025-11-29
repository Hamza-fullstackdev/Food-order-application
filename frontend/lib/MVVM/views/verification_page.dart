import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Resources/app_colors.dart';
import 'package:frontend/Resources/assetsPath.dart';
import 'package:frontend/Widgets/common_button.dart';
import 'package:frontend/Widgets/text_view.dart';
import 'package:pinput/pinput.dart';

class VerifyCode extends StatefulWidget {
  const VerifyCode({super.key});

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final String _email = 'example@gmail.com';

  late final TextEditingController _emailController;
  late final TextEditingController _pinController;
  late final FocusNode _focusNode;
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _pinController = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _pinController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PinTheme defaultTheme = PinTheme(
      width: kIsWeb ? 164 : 130,
      height: kIsWeb ? 64 : 50,
      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      margin: EdgeInsets.all(kIsWeb ? 10 : 5),
      decoration: BoxDecoration(
        color: AppColors.lightGreyColor2,
        borderRadius: BorderRadius.all(Radius.circular(kIsWeb ? 10 : 5)),
      ),
    );
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              color: AppColors.blackColor,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.40,
              child: Stack(
                children: [
                  Image.asset(AssetsPath.decorationImg2),
                  Padding(
                    padding: const EdgeInsets.only(top: 48, left: 16),
                    child: CircleAvatar(
                      backgroundColor: AppColors.lightGreyColor2,
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
                            text: "Verification",
                            colors: AppColors.whiteColor,
                          ),
                        ),
                        SizedBox(height: 5),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: _email,

                                style: TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                            text: 'We have sent a code to your email\n',
                            style: TextStyle(
                              fontSize: 16,
                              // ignore: deprecated_member_use
                              color: AppColors.whiteColor.withOpacity(0.7),
                            ),
                          ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextViewNormal(text: 'CODE',size: 14,),
                          RichText(
                            text: TextSpan(
                              text: 'Resend',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: AppColors.lightBlackColor,
                                fontSize: 14,
                              ),
                              children: [
                                TextSpan(
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.darkBlack,
                                    fontSize: 12,
                                  ),
                                  text: ' in.50sec',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),

                      Center(
                        child: Pinput(
                          length: 6,
                          controller: _pinController,
                          focusNode: _focusNode,
                          obscureText: false,
                          focusedPinTheme: defaultTheme.copyDecorationWith(
                            color: AppColors.darkOrangeColor,
                          ),
                          defaultPinTheme: defaultTheme,
                          onCompleted: (value) {},
                        ),
                      ),

                      SizedBox(height: 10),
                      ButtonContainerFilled(
                        height: 54,
                        width: MediaQuery.of(context).size.width,
                        function: () {
                          Navigator.of(context).pop();
                        },
                        child: TextViewNormal(
                          text: "Verify",
                          colors: AppColors.whiteColor,
                        ),
                      ),
                      SizedBox(height: 10),
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