// ignore_for_file: deprecated_member_use, file_names, avoid_types_as_parameter_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart' hide Card;
import 'package:frontend/MVVM/ViewModel/address_provider.dart';
import 'package:frontend/MVVM/ViewModel/home_provider.dart';
import 'package:frontend/MVVM/models/GetProduct_ByCategoryId.dart';
import 'package:frontend/MVVM/models/categoryModle.dart';
import 'package:frontend/MVVM/views/ProfileScreen.dart';
import 'package:frontend/MVVM/views/cart_Screen.dart';
import 'package:frontend/MVVM/views/mealMenu_Screen.dart';
import 'package:frontend/MVVM/views/productDetailscreen.dart';
import 'package:frontend/Resources/app_colors.dart';
import 'package:frontend/Resources/app_routes.dart';
import 'package:frontend/Resources/assetsPath.dart';
import 'package:frontend/Resources/status.dart';
import 'package:frontend/Widgets/text_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class ProductScreen extends StatefulWidget {
//   const ProductScreen({super.key});

//   @override
//   State<ProductScreen> createState() => _ProductScreenState();
// }

// class _ProductScreenState extends State<ProductScreen> {
//   int selectedIndex = 0;
//   final PageController _controller = PageController();

//   final List<Color> posterButtonTextColor = [
//     Colors.red,
//     Colors.pink,
//     const Color(0xffFF8080),
//   ];
//   final List<Map<String, dynamic>> posters = [
//     {
//       "title": "Special Offer\nfor March",
//       "subtitle": "We are here with the best\ndeserts in town.",
//       "image": AssetsPath.posterBugerPic,
//       "colors": [AppColors.orangeColor, AppColors.lightOrangeColor],
//     },
//     {
//       "title": "New Arrival\nSummer Drinks",
//       "subtitle": "Cool down with our\nfresh collection.",
//       "image": AssetsPath.posterDrink,
//       "colors": [
//         AppColors.orangeColor,
//         const Color(0xffFF8080),
//         AppColors.lightOrangeColor,
//       ],
//     },
//     {
//       "title": "Weekend Sale\n50% OFF",
//       "subtitle": "Grab your favorite food\nbefore it's gone!",
//       "image": AssetsPath.posterSecondBurger,
//       "colors": [
//         AppColors.orangeColor,
//         const Color(0xffFF8080),
//         AppColors.lightOrangeColor,
//       ],
//     },
//   ];
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       final provider = Provider.of<HomeProvider>(context, listen: false);
//       provider.fetchCategories();
//       provider.fetchProductById(provider.categoryId);
//       // await Stripe.instance.applySettings();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.only(
//                   top: MediaQuery.of(context).padding.top,
//                 ),
//                 color: Colors.transparent,
//                 child: AppBar(
//                   surfaceTintColor: Colors.transparent,
//                   backgroundColor: Colors.transparent,
//                   elevation: 0,
//                   leading: Padding(
//                     padding: const EdgeInsets.all(18.0),
//                     child: InkWell(
//                       child: Image.asset(
//                         AssetsPath.menuIcon,
//                         width: 10,
//                         height: 1,
//                       ),
//                     ),
//                   ),
//                   title: Row(
//                     children: [
//                       const Icon(
//                         Icons.location_on,
//                         color: AppColors.darkOrangeColor,
//                         size: 20,
//                       ),
//                       const SizedBox(width: 4),
//                       Expanded(
//                         flex: 2,
//                         child: Consumer<AddressProvider>(
//                           builder: (context, value, child) => Text(
//                             softWrap: true,
//                             maxLines: 2,
//                             value.currentAddress,
//                             style: GoogleFonts.poppins(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                               color: const Color(0xff4B5563),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   actions: [
//                     InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const ProfilePage(),
//                           ),
//                         );
//                       },
//                       child: const CircleAvatar(
//                         backgroundImage: AssetImage(
//                           "assets/images/profile_pic.jpg",
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                   ],
//                 ),
//               ),

//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final PageController _controller = PageController();

  final List<Color> posterButtonTextColor = [
    Colors.red,
    Colors.pink,
    const Color(0xffFF8080),
  ];

  final List<Map<String, dynamic>> posters = [
    {
      "title": "Special Offer\nfor March",
      "subtitle": "We are here with the best\ndeserts in town.",
      "image": AssetsPath.posterBugerPic,
      "colors": [AppColors.orangeColor, AppColors.lightOrangeColor],
    },
    {
      "title": "New Arrival\nSummer Drinks",
      "subtitle": "Cool down with our\nfresh collection.",
      "image": AssetsPath.posterDrink,
      "colors": [
        AppColors.orangeColor,
        const Color(0xffFF8080),
        AppColors.lightOrangeColor,
      ],
    },
    {
      "title": "Weekend Sale\n50% OFF",
      "subtitle": "Grab your favorite food\nbefore it's gone!",
      "image": AssetsPath.posterSecondBurger,
      "colors": [
        AppColors.orangeColor,
        const Color(0xffFF8080),
        AppColors.lightOrangeColor,
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<HomeProvider>(context, listen: false);
      provider.fetchCategories();
      provider.fetchProductById(provider.categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// 🔥 FULL SCREEN LOADING CONTROLLER
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          final bool isLoading =
              homeProvider.categoryResponse.status == ResponseStatus.loading ||
              homeProvider.productResponse.status == ResponseStatus.loading;

          return Stack(
            children: [
              /// ================= MAIN UI =================
              if (!isLoading)
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top,
                      ),
                      child: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        leading: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Image.asset(AssetsPath.menuIcon),
                        ),
                        title: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: AppColors.darkOrangeColor,
                              size: 20,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Consumer<AddressProvider>(
                                builder: (_, value, __) => Text(
                                  value.currentAddress,
                                  maxLines: 2,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: const Color(0xff4B5563),
                                  ),
                                ),
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
                                  builder: (_) => const ProfilePage(),
                                ),
                              );
                            },
                            child: const CircleAvatar(
                              backgroundImage: AssetImage(
                                "assets/images/profile_pic.jpg",
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                      ),
                    ),

                    /// ================= BODY =================
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color.fromARGB(
                                        255,
                                        231,
                                        180,
                                        166,
                                      ).withOpacity(.3),
                                      const Color.fromARGB(
                                        255,
                                        231,
                                        186,
                                        166,
                                      ).withOpacity(.4),
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
                                      prefixIcon: const Icon(
                                        CupertinoIcons.search,
                                        size: 20,
                                        color: Colors.black,
                                      ),
                                      prefixIconConstraints:
                                          const BoxConstraints(),
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(),
                                    ),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 25),
                              SizedBox(
                                height: 180,
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
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 6),
                                                Text(
                                                  poster["subtitle"],
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const SizedBox(height: 12),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white,
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Positioned.fill(
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Image.asset(
                                                  poster["image"],
                                                  height: 143,
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
                                      width: 8,
                                      height: 8,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    dotDecoration: DotDecoration(
                                      width: 8,
                                      height: 8,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    spacing: 8,
                                    activeColorOverride: (i) => [
                                      AppColors.darkOrangeColor,
                                      AppColors.darkOrangeColor,
                                      AppColors.darkOrangeColor,
                                    ][i],
                                    inActiveColorOverride: (i) =>
                                        Colors.grey[400]!,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Consumer<HomeProvider>(
                                builder: (context, value, child) {
                                  if (value.categoryResponse.status ==
                                      ResponseStatus.success) {
                                    final List<Categories> categoriesList =
                                        value.categoryResponse.data;
                                    return SizedBox(
                                      height: 45,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: categoriesList.length,
                                        itemBuilder: (context, index) {
                                          final Categories category =
                                              categoriesList[index];
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 6,
                                            ),
                                            child: ChoiceChip(
                                              showCheckmark: false,
                                              label: Text(
                                                category.name ?? '',
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16.7,
                                                  color:
                                                      value.categoryIndex ==
                                                          index
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ),
                                              avatar: SizedBox(
                                                height: 70,
                                                width: 70,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadiusGeometry.circular(
                                                        20,
                                                      ),
                                                  child: Image.network(
                                                    category.image ?? '',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              selected:
                                                  value.categoryIndex == index,
                                              selectedColor:
                                                  AppColors.darkOrangeColor,
                                              backgroundColor: Colors.white,
                                              side: BorderSide(
                                                color: 0 == index
                                                    ? Colors.transparent
                                                    : AppColors.darkOrangeColor,
                                                width: 1.5,
                                              ),
                                              onSelected: (num) {
                                                value.updateCategoryId(
                                                  category.cId!,
                                                  index,
                                                );
                                                value.fetchProductById(
                                                  category.cId!,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  } else if (value.categoryResponse.status ==
                                      ResponseStatus.failed) {
                                    return TextViewNormal(
                                      text:
                                          'Result is: ${value.categoryResponse.message!}',
                                    );
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                },
                              ),
                              const SizedBox(height: 3),
                              Consumer<HomeProvider>(
                                builder: (context, value, child) {
                                  if (value.productResponse.status ==
                                      ResponseStatus.success) {
                                    final List<Products> productsList =
                                        value.productResponse.data;
                                    return SizedBox(
                                      height: 250,
                                      child: ListView.builder(
                                        physics: const BouncingScrollPhysics(
                                          parent:
                                              AlwaysScrollableScrollPhysics(),
                                        ),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: productsList.length,
                                        itemBuilder: (context, index) {
                                          final data = productsList[index];
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8.0,
                                              bottom: 8,
                                              left: 4,
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  AppRoutes.productDetailPage,
                                                  arguments: [
                                                    productsList[0],
                                                    '4.3',
                                                    'Free',
                                                    '20 min',
                                                  ],
                                                );
                                              },
                                              child: Container(
                                                width: 160,
                                                margin: const EdgeInsets.only(
                                                  right: 12,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color:
                                                          Colors.grey.shade200,
                                                      blurRadius: 6,
                                                      spreadRadius: 2,
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    8,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.star,
                                                            color: Color(
                                                              0xffFF9F06,
                                                            ),
                                                            size: 16,
                                                          ),
                                                          const SizedBox(
                                                            width: 4,
                                                          ),
                                                          Text(
                                                            "4.5",
                                                            style:
                                                                GoogleFonts.poppins(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Center(
                                                        child: Container(
                                                          height: 100,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  10,
                                                                ),
                                                            image: DecorationImage(
                                                              image: NetworkImage(
                                                                data.image ??
                                                                    AssetsPath
                                                                        .burgerPic,
                                                              ),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                        data.name ?? 'N/A',
                                                        style:
                                                            GoogleFonts.poppins(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                      ),
                                                      Text(
                                                        data.shortDescription ??
                                                            'No description',
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.poppins(
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                      ),
                                                      const Spacer(),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "\$${data.price?.toString() ?? '0'}",
                                                            style: GoogleFonts.poppins(
                                                              color: AppColors
                                                                  .darkOrangeColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (
                                                                        context,
                                                                      ) =>
                                                                          CartPage(),
                                                                ),
                                                              );
                                                            },
                                                            child: const Icon(
                                                              size: 32,
                                                              Icons.add_circle,
                                                              color: AppColors
                                                                  .darkOrangeColor,
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
                                    );
                                  } else if (value.productResponse.status ==
                                      ResponseStatus.failed) {
                                    return TextViewNormal(
                                      text:
                                          'Result is: ${value.productResponse.message!}',
                                    );
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                },
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text(
                                    "Popular Meal Menu",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Spacer(),
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
                                          builder: (context) =>
                                              const MealMenuScreen(),
                                        ),
                                      );
                                    },
                                    child: const Icon(
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
                                      builder: (context) => ProductDetailPage(),
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
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                          child: Image.asset(
                                            AssetsPath.burgerDetailPic,
                                            height: 60,
                                            width: 80,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
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
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "\$15",
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              color: AppColors.darkOrangeColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              /// ================= FULL SCREEN LOADER =================
              if (isLoading) fullScreenLoader(),
            ],
          );
        },
      ),
    );
  }
}

/// ================= LOADING WIDGET =================
Widget fullScreenLoader() {
  return Container(
    color: Colors.white,
    padding: EdgeInsets.all(30),
    width: double.infinity,
    height: double.infinity,
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.6, end: 1.0),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            builder: (_, scale, __) => Transform.scale(
              scale: scale,
              child: Icon(
                Icons.fastfood,
                size: 80,
                color: AppColors.darkOrangeColor,
              ),
            ),
          ),
          const SizedBox(height: 20),
          LinearProgressIndicator(
            borderRadius: BorderRadius.circular(30),
            minHeight: 9,

            valueColor: AlwaysStoppedAnimation(AppColors.darkOrangeColor),
          ),
          const SizedBox(height: 16),
          Text(
            "Loading delicious food...",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ),
  );
}
