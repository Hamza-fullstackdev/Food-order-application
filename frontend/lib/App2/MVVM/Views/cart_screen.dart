import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/App2/Resources/assetsPath.dart';
import 'package:frontend/App2/Widgets/Common/app_contants.dart';
import 'package:frontend/App2/Widgets/Common/text_view.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppContants.whiteColor,
      body: Stack(
        children: [
          Image.asset(
            AssetsPath.mealMenuTopPattren,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xffFFE5E5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        CupertinoIcons.back,
                        color: Color(0xffD61355),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  TextView(
                    text: "Order details",
                    size: 25,
                    color: AppContants.blackColor,
                    weight: 700,
                  ),
                  Container(
                    height: 500,
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Card.outlined(
                          color: AppContants.offWhiteColor,
                          shadowColor: AppContants.lightGrey,
                          elevation: 5,
                          child: SizedBox(
                            height: 100,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    AssetsPath.burgerDetailPic,
                                    height: 100,
                                    width: 60,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Chicken Burger",
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.poppins(
                                            color: AppContants.blackColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "Burger Factory LTD",
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          '\$20',
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            color: const Color(0xffD61355),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color(0xffFFE5E5),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "-",
                                          style: GoogleFonts.poppins(
                                            color: AppContants.redColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400
                                          ),
                                        ),
                                      ),
                                    ),

                                    Container(
                                      height: 30,
                                      width: 30,
                                      child: Center(
                                        child: Text(
                                          "1",
                                          style: GoogleFonts.poppins(
                                            color: AppContants.blackColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400
                                          ),
                                        ),
                                      ),
                                    ),

                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),

                                        color: AppContants.redColor,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "+",
                                          style: GoogleFonts.poppins(
                                            color: AppContants.whiteColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400
                                          ),
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
