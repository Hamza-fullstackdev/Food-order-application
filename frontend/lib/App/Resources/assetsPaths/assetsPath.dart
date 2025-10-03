class AssetsPath {
  static const String baseUrl = 'assets/images/';

  static const String bgImage = '${baseUrl}bg_image.png';

  static const String bikeImage = '${baseUrl}bike_image.jpeg';
  static const String introImage1 = '${baseUrl}intro_img1.png';
  static const String introImage2 = '${baseUrl}intro_img2.png';

  static const String menuIcon = '${baseUrl}menu_Icon.jpeg';
  static const String onBoardBg = '${baseUrl}on_board_bg.jpg';

  static const String profilePic = '${baseUrl}profile_pic.jpg';
  static const String burgerPic = '${baseUrl}burger.png';
  static const String burgerDetailPic = '${baseUrl}burgerDetail.jpeg';
  static const String posterBugerPic = '${baseUrl}posterBurger.jpg';
  static const String cardBackGroundpic =
      '${baseUrl}card_BACKGROUND.png'; // image jo card k back pr lagni ha
  static const String posterDrink = '${baseUrl}posterDrinks.jpeg';
  static const String posterSecondBurger = '${baseUrl}posterSecondBurger.jpeg';

  static const String productScreenGroup =
      '${baseUrl}Group.png'; // imagie to show on the top of product screen  ya pic top pr lagani ha back pr
  static const String mealMenuTopPattren =
      '${baseUrl}mealMenu_pattren.jpg'; // image to show on the top header  of mealMenuScreen
}

class AnimationPaths
{

    static const String baseUrl = 'assets/animations/';
      static const String loading = '${baseUrl}loading.json';
        static const String loading2 = '${baseUrl}loading2.json';

}
/*   

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/App/MVVM/views/ProfileScreen.dart';
import 'package:frontend/App/Resources/assetsPaths/assetsPath.dart';
import 'package:frontend/App/MVVM/views/mealMenu_Screen.dart';
import 'package:frontend/App/MVVM/views/productDetailscreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class MyBehavior extends ScrollBehavior {
//   @override
//   ScrollPhysics getScrollPhysics(BuildContext context) =>
//       BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());

//   // Android کا blue glow disable کرنے کے لیے:
//   @override
//   Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
//     return child;
//   }
// }
class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<String> items = ["Burger", "Pizza", "Sandwich"];
  int selectedIndex = 0;
  final PageController _controller = PageController();
  final List<Color> posterButtonTextColor = [
    Colors.red,
    Colors.pink,
    Color(0xffFF8080),
  ];
  final List<Map<String, dynamic>> posters = [
    {
      "title": "Special Offer\nfor March",
      "subtitle": "We are here with the best\ndeserts in town.",
      "image": AssetsPath.posterBugerPic,
      "colors": [Color(0xffFF0000), Color(0xffFFB4B4)],
    },
    {
      "title": "New Arrival\nSummer Drinks",
      "subtitle": "Cool down with our\nfresh collection.",
      "image": AssetsPath.posterDrink,
      "colors": [Colors.pink, Color(0xffFF8080), Color(0xffFECFEF)],
    },
    {
      "title": "Weekend Sale\n50% OFF",
      "subtitle": "Grab your favorite food\nbefore it's gone!",
      "image": AssetsPath.posterSecondBurger,
      "colors": [Color(0xffFF8080), Color(0xffFF8080), Color(0xffFFB4B4)],
    },
  ];
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isTablet = constraints.maxWidth > 600;
          final bool isLandscape =
              MediaQuery.of(context).orientation == Orientation.landscape;
          final double topImageHeight = isLandscape
              ? constraints.maxHeight * 0.15
              : constraints.maxHeight * 0.18;
          final double posterHeight = isLandscape
              ? constraints.maxHeight * 0.50
              : constraints.maxHeight * 0.22;
          final double categoryHeight = isLandscape ? 40.0 : 45.0;
          final double itemsListHeight = isLandscape
              ? constraints.maxHeight * 0.70
              : constraints.maxHeight * 0.3;
          final double itemWidth = isTablet
              ? constraints.maxWidth * 0.2
              : constraints.maxWidth * 0.4;
          final double paddingHorizontal = isTablet ? 32.0 : 18.0;

          return Stack(
            children: [
              Positioned(
                left: 0,
                right: -25,
                top: 35,
                child: SizedBox(
                  height: topImageHeight,
                  child: Image.asset(
                    "assets/images/Group2.jpg",
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                    ),
                    color: Colors.transparent,
                    child: AppBar(
                      surfaceTintColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leading: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: InkWell(
                          child: Image.asset(
                            width: 10,
                            height: 1,
                            AssetsPath.menuIcon,
                            // fit: BoxFit.,
                          ),
                        ),
                      ),
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
                      physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: paddingHorizontal,
                        ),
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
                            SizedBox(height: 30),
                            SizedBox(
                              height: posterHeight,
                              width: double.infinity,
                              child: PageView.builder(
                                padEnds: false,
                                controller: _controller,
                                itemCount: posters.length,
                                itemBuilder: (context, index) {
                                  final poster = posters[index];
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      gradient: LinearGradient(
                                        colors: poster["colors"],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 16,
                                        top: 20,
                                      ),
                                      child: Stack(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                poster["title"],
                                                style: GoogleFonts.roboto(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 6),
                                              Text(
                                                poster["subtitle"],
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.white,
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 18,
                                                        vertical: 6,
                                                      ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8,
                                                        ),
                                                  ),
                                                ),
                                                onPressed: () {},
                                                child: Text(
                                                  "Buy Now",
                                                  style: GoogleFonts.poppins(
                                                    color:
                                                        posterButtonTextColor[index],
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Positioned.fill(
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Image.asset(
                                                poster["image"],
                                                height: posterHeight * 0.75,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 12),
                            Center(
                              child: SmoothPageIndicator(
                                controller: _controller,
                                count: posters.length,
                                effect: CustomizableEffect(
                                  activeDotDecoration: DotDecoration(
                                    width: 220,
                                    height: 8,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  dotDecoration: DotDecoration(
                                    width: 15,
                                    height: 8,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  spacing: 8,
                                  activeColorOverride: (i) => [
                                    Colors.red,
                                    Colors.pink,
                                    Color(0xffFF8080),
                                  ][i],
                                  inActiveColorOverride: (i) =>
                                      Colors.grey[400]!,
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            SizedBox(
                              height: categoryHeight,
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
                              height: itemsListHeight,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics(),
                                ),
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
                                        // height: 100,
                                        width: itemWidth,
                                        margin: EdgeInsets.only(right: 12),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
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
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 8),
                                              Center(
                                                child: SizedBox(
                                                  height: itemsListHeight * 0.7,
                                                  child: Image.asset(
                                                    data['image'],
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "\$${data['price'].toString()}",
                                                    style: GoogleFonts.poppins(
                                                      color: Color(0xffD61355),
                                                      fontWeight:
                                                          FontWeight.bold,
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
                            SizedBox(height: 6),
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
                                  child: isLandscape
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              child: Image.asset(
                                                AssetsPath.burgerDetailPic,
                                                height:
                                                    constraints.maxHeight * 0.1,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(height: 8),
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
                                            SizedBox(height: 8),
                                            Align(
                                              alignment: Alignment.centerRight,
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
                                        )
                                      : Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(6),
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
                                              padding: const EdgeInsets.all(
                                                8.0,
                                              ),
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
          );
        },
      ),
    );
  }
}

*/