import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/App/MVVM/views/ProfileScreen.dart';
import 'package:frontend/App/Resources/assetsPaths/assetsPath.dart';
import 'package:frontend/App/MVVM/views/mealMenu_Screen.dart';
import 'package:frontend/App/MVVM/views/productDetailscreen.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<String> items = ["Burger", "Pizza", "Sandwich"];
  int selectedIndex = 0;
  List<Map<String, dynamic>> itemsList = [
    {'name': 'Chicken Burger', 'price': '20', 'image': AssetsPath.burgerPic},
    {
      'name': 'Zinger Burger',
      'price': '30',
      'image': AssetsPath.burgerDetailPic,
    },
    {
      'name': 'Pepper Pizza',
      'price': '40',
      'image': AssetsPath.burgerDetailPic,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background pattern at the top
          Positioned(
            left: 0,
            right: -65,
            // bottom: 0,
            top: 39,
            child: SizedBox(
              height: 125,

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
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                ),
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
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                          "assets/images/profile_pic.jpg",
                        ),
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
                        SizedBox(height: 8),
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
                        SizedBox(height: 25),

                        Container(
                          height: 190,
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
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      "We are here with the best\ndeserts intown.",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 18,
                                          vertical: 6,
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

                        SizedBox(height: 75),

                        SizedBox(
                          height: 45,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                ),
                                child: ChoiceChip(
                                  showCheckmark: false,
                                  label: Text(
                                    items[index],
                                    style: GoogleFonts.poppins(
                                      color: selectedIndex == index
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  avatar: Icon(
                                    Icons.fastfood,
                                    color: selectedIndex == index
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  selected: selectedIndex == index,
                                  selectedColor: Color(0xffD61355),
                                  backgroundColor: Colors.white,
                                  side: BorderSide(
                                    color: selectedIndex == index
                                        ? Colors.transparent
                                        : Colors.red,
                                    width: 1.5,
                                  ),
                                  onSelected: (value) {
                                    setState(() => selectedIndex = index);
                                  },
                                ),
                              );
                            },
                          ),
                        ),

                        SizedBox(height: 3),
                        SizedBox(
                          height: 250,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: itemsList.length,

                            itemBuilder: (context, index) {
                              final data = itemsList[index];
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
                                            ProductDetailScreen(
                                              imagePath: data['image'],
                                            ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 160,
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
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Center(
                                            child: SizedBox(
                                              height: 100,
                                              child: Image.asset(
                                                data['image'],
                                                // height: 90,
                                                // fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            data['name'].toString(),
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            "100 gr chicken + tomato\ncheese lettuce",
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "\$${data['price'].toString()}",
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
                                builder: (context) => ProductDetailScreen(
                                  imagePath: AssetsPath.burgerPic,
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
