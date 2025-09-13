import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Resources/assetsPaths/assetsPath.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),

      // appBar: PreferredSize(
      //   preferredSize: Size(0, 100),
      // child:
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffFFFFFF),
        // // backgroundColor: Colors.pink,
        leading: Image.asset(AssetsPath.menuIcon),

        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(size: 21, Icons.location_on, color: Color(0xffFF0000)),
              Text(
                'Freedom way, Lekki phase',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff4B5563),
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 18,
              child: Image.asset(
                height: 100,

                AssetsPath.profilePic,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20  , bottom: 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // Rounded border
                gradient: LinearGradient(
                  colors: [
                    Color(0xffE7A6C6).withOpacity(.3),
                    Color(0xffE7A6C6).withOpacity(.4),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 35.0),
                child: TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      CupertinoIcons.search,
                      size: 20,
                      color: Colors.black,
                    ),
                    prefixIconConstraints: BoxConstraints(),
                    hintText: 'Search',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide
                          .none, // no hard border, just gradient container
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(),
                  ),

                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
           Container(
              height: 189,
              width: double.infinity,

              decoration: BoxDecoration(
                color: Color(0xffFE9BAB),

                // gradient: LinearGradient(
                //   colors: [
                //     // Colors.pink.withOpacity(.9),
                //     // Colors.pink.withOpacity(.6),
                //     Color(0xffFE9BAB),
                //   ],
                // ),
                borderRadius: BorderRadius.circular(10),
              ),

              child: Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 8, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '50-40% OFF',
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Now in (Products)\nAll colours',
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              height: 2,
                            ),
                          ),
                          SizedBox(
                            height: 45,
                            width: 120,
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  width: 1.5,
                                  color: Colors.white,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.center, 
                                children: [
                                  Flexible(
                                    // 👈 overflow prevent karega
                                    child: Text(
                                      'Shop Now',
                                      // maxLines: 1,
                                      // overflow:
                                      //     TextOverflow.ellipsis, 
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  // const SizedBox(width: 6),
                                  Icon(
                                    Icons.arrow_forward_outlined,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Image.asset(Assets.coffeScreen),
                  ],
                ),
              ),
           ),

        ],
      ),
    );
  }
}
