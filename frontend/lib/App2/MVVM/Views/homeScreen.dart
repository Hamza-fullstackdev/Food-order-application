import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/App/MVVM/views/mealMenu_Screen.dart';
import 'package:frontend/App/Resources/assetsPaths/assetsPath.dart';
import 'package:frontend/App2/MVVM/ViewModel/product_provider.dart';
import 'package:frontend/App2/MVVM/Views/detail_screen.dart';
import 'package:frontend/App2/Widgets/Common/app_contants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final _indicatorController;

  @override
  void initState() {
    _indicatorController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background pattern at the top
          Positioned(
            left: 0,
            right: -25,
            // bottom: 0,
            top: 29,
            child: SizedBox(
              height: 90,

              child: Image.asset(
                "assets/images/Group2.jpg",
                filterQuality: FilterQuality.high,
                fit: BoxFit.contain,
              ),
            ),
          ),

          Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 16),
                color: Colors.transparent,
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: Icon(Icons.menu, color: Colors.black),
                  title: Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.red, size: 20),
                      SizedBox(width: 4),
                      Text(
                        "Freedom way, Lekki phase",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff4B5563),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        "assets/images/profile_pic.jpg",
                      ),
                    ),
                    SizedBox(width: 12),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 0),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
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
                                  borderSide: BorderSide.none,
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
                        SizedBox(height: 8),

                        Container(
                          height: 170,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              colors: [Color(0xffFF0000), Color(0xffFFB4B4)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Special Offer\nfor March",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      "We are here with the best\ndeserts intown.",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 8,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: Text(
                                        "Buy Now",
                                        style: GoogleFonts.poppins(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Image.asset(AssetsPath.burgerPic, height: 120),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Center(
                          child: SmoothPageIndicator(
                            controller: _indicatorController,
                            count: 3,
                            effect: WormEffect(
                              dotHeight: 9,
                              dotWidth: 9,
                              dotColor: AppContants.lightGrey,
                              activeDotColor: AppContants.redColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 6),

                        SizedBox(
                          height: 43,
                          child: FutureBuilder(
                            future: productProvider.categoriesData(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return CircularProgressIndicator();
                              } else {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      productProvider.categoryList.length,
                                  itemBuilder: (context, index) {
                                    // print(productProvider.categoryList[index].name);
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          productProvider.categoriesData();
                                        },
                                        child: ChoiceChip(
                                          showCheckmark: false,
                                          label: Text(
                                            productProvider
                                                    .categoryList[index]
                                                    .name ??
                                                "Error",
                                            style: GoogleFonts.poppins(
                                              color:
                                                  productProvider
                                                          .selectedIndex ==
                                                      index
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                          avatar: Icon(
                                            Icons.fastfood,
                                            color:
                                                productProvider.selectedIndex ==
                                                    index
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                          selected:
                                              productProvider.selectedIndex ==
                                              index,
                                          selectedColor: Color(0xffD61355),
                                          backgroundColor: Colors.white,
                                          side: BorderSide(
                                            color:
                                                productProvider.selectedIndex ==
                                                    index
                                                ? Colors.transparent
                                                : Colors.red,
                                            width: 1.5,
                                          ),
                                          onSelected: (value) {
                                            //  = productProvider.categoryList[selectedIndex].sId;
                                            productProvider.setIndex(
                                              index,
                                              productProvider
                                                      .categoryList[index]
                                                      .sId ??
                                                  "Invalid Id",
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ),

                        SizedBox(height: 0),
                        SizedBox(
                          height: 237,
                          child: FutureBuilder(
                            future: productProvider.getProducts(
                              productProvider.categoryId,
                            ),
                            builder: (context, snapshot) => ListView.builder(
                              scrollDirection: Axis.horizontal,

                              itemCount: productProvider.productList.length,

                              itemBuilder: (context, index) {
                                final data = productProvider.productList[index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8.0,
                                    bottom: 8,
                                    left: 4,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailScreen(
                                                imagePath: productProvider.productList[index].sId!,
                                              ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 155,
                                      margin: EdgeInsets.only(right: 12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade200,
                                            blurRadius: 6,
                                            spreadRadius: 2,
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Color(0xffFF9F06),
                                                  size: 16,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  "4.5",

                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 0),
                                            Center(
                                              child: SizedBox(
                                                height: 76,
                                                child: Image.network(
                                                  data.image!,
                                                  // height: 90,
                                                  // fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 1),
                                            Text(
                                              data.name!,
                                              style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              data.shortDescription!,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Spacer(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  data.price.toString(),
                                                  style: GoogleFonts.poppins(
                                                    color: Color(0xffD61355),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {},
                                                  child: Icon(
                                                    size: 32,
                                                    Icons.add_circle,
                                                    color: Color(0xffD61355),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        Row(
                          children: [
                            Text(
                              "Popular Meal Menu",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "See All",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MealMenuScreen(),
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.play_arrow,
                                size: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),

                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(imagePath: productProvider.productList[0].sId!,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 2,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Image.asset(
                                      AssetsPath.burgerDetailPic,
                                      height: 60,
                                      width: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Pepper Pizza",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "5kg box of Pizza",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "\$15",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        color: Color(0xffD61355),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
