

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/App/Core/status.dart';
import 'package:frontend/App/MVVM/models/GetProduct_ByCategoryId.dart';
import 'package:frontend/App/MVVM/viewModels/ProductViewModel/productViewModel.dart';
import 'package:frontend/App/MVVM/viewModels/categoryViewModel/categoryViewModel.dart';
import 'package:frontend/App/MVVM/views/ProfileScreen.dart';
import 'package:frontend/App/MVVM/views/cart_Screen.dart';
import 'package:frontend/App/Resources/assetsPaths/assetsPath.dart';
import 'package:frontend/App/MVVM/views/mealMenu_Screen.dart';
import 'package:frontend/App/MVVM/views/productDetailscreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int selectedIndex = 0;
  final PageController _controller = PageController();
  bool _isInitialized = false;
  bool showAnimation = true;

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
      "colors": [const Color(0xffFF0000), const Color(0xffFFB4B4)],
    },
    {
      "title": "New Arrival\nSummer Drinks",
      "subtitle": "Cool down with our\nfresh collection.",
      "image": AssetsPath.posterDrink,
      "colors": [Colors.pink, const Color(0xffFF8080), const Color(0xffFECFEF)],
    },
    {
      "title": "Weekend Sale\n50% OFF",
      "subtitle": "Grab your favorite food\nbefore it's gone!",
      "image": AssetsPath.posterSecondBurger,
      "colors": [
        const Color(0xffFF8080),
        const Color(0xffFF8080),
        const Color(0xffFFB4B4),
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          showAnimation = false;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _isInitialized = true;
      Future.microtask(() {
        Provider.of<CategoryViewModel>(context, listen: false).getCategory();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (showAnimation) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Lottie.asset(
            AnimationPaths.loading2,
            width: 200,
            height: 200,
            repeat: true,
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: -25,
            top: 35,
            child: SizedBox(
              height: 140,
              child: Image.asset(
                "assets/images/Group2.jpg",
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
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
                  surfaceTintColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: InkWell(
                      child: Image.asset(
                        AssetsPath.menuIcon,
                        width: 10,
                        height: 1,
                      ),
                    ),
                  ),
                  title: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "Freedom way, Lekki phase",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff4B5563),
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
                            builder: (context) => const ProfileScreen(),
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
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
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
                                const Color(0xffE7A6C6).withOpacity(.3),
                                const Color(0xffE7A6C6).withOpacity(.4),
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
                                prefixIconConstraints: const BoxConstraints(),
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
                                contentPadding: const EdgeInsets.symmetric(),
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
                                  padding: const EdgeInsets.only(left: 16),
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
                                              backgroundColor: Colors.white,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 18,
                                                    vertical: 6,
                                                  ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
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
                                          alignment: Alignment.bottomRight,
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
                                const Color(0xffFF8080),
                              ][i],
                              inActiveColorOverride: (i) => Colors.grey[400]!,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Consumer<CategoryViewModel>(
                          builder: (context, categoryVM, _) {
                            final response = categoryVM.categoryResponce;

                            switch (response.status) {
                              case Status.LOADING:
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );

                              case Status.ERROR:
                                return Center(
                                  child: Text(response.message.toString()),
                                );

                              case Status.SUCCESS:
                                final categories = response.data;
                                if (categories == null ||
                                    categories.categories == null ||
                                    categories.categories!.isEmpty) {
                                  return const Center(
                                    child: Text("No categories found"),
                                  );
                                }

                                return SizedBox(
                                  height: 45,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: categories.categories?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      final category =
                                          categories.categories![index];

                                      //  final products = response.data?.products ?? [];

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                        ),
                                        child: Consumer<ProductViewModel>(
                                          builder: (context, productVM, _) {
                                            return ChoiceChip(
                                              showCheckmark: false,
                                              label: Text(
                                                category.name ?? '',
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16.7,
                                                  color:
                                                      categoryVM.index == index
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
                                                  categoryVM.index == index,
                                              selectedColor: Color(0xffD61355),
                                              backgroundColor: Colors.white,
                                              side: BorderSide(
                                                color: categoryVM.index == index
                                                    ? Colors.transparent
                                                    : Colors.red,
                                                width: 1.5,
                                              ),
                                              onSelected: (value) {
                                                categoryVM.changeIndex(
                                                  index,
                                                ); // Update index in CategoryViewModel
                                                if (category.cId != null &&
                                                    category.cId!.isNotEmpty) {
                                                  productVM.getAllProducts(
                                                    pId: category.cId!,
                                                  );
                                                } else {
                                                  productVM.setError(
                                                    "Invalid category ID",
                                                  );
                                                }
                                              },
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                );
                              default:
                                return const Center(
                                  child: Text("Something went wrong"),
                                );
                            }
                          },
                        ),
                        const SizedBox(height: 3),
                        SizedBox(
                          height: 250,
                          child: Consumer<ProductViewModel>(
                            builder: (context, productVM, _) {
                              final response = productVM.productResponce;
                              switch (response.status) {
                                case Status.LOADING:
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                case Status.ERROR:
                                  return Center(
                                    child: Text(response.message ?? "Error"),
                                  );
                                case Status.SUCCESS:
                                  final products = response.data;
                                  if (products == null ||
                                      products.products!.isEmpty) {
                                    return const Center(
                                      child: Text("No products found"),
                                    );
                                  }
                                  return ListView.builder(
                                    physics: const BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics(),
                                    ),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: products.products?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      final data = products.products![index];
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
                                                      pId: data.sId?? '',
                                                      imagePath:
                                                          data.image ??
                                                          AssetsPath.burgerPic,
                                                          shortDetail: data.shortDescription ?? 'N/A',
                                                          name: data.name ?? 'N/A',
                                                          productPrice: data.price?.toString() ?? '0' ,
                                                          detail: data.description?? 'N/A' ,
                                                        variants: data.variantGroups as List<VariantGroups>,
                                              )
                                            )  )  ;
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
                                                      const Icon(
                                                        Icons.star,
                                                        color: Color(
                                                          0xffFF9F06,
                                                        ),
                                                        size: 16,
                                                      ),
                                                      const SizedBox(width: 4),
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
                                                    child: SizedBox(
                                                      height: 100,
                                                      child: Image.network(
                                                        data.image ??
                                                            AssetsPath
                                                                .burgerPic,
                                                        fit: BoxFit.cover,
                                                        errorBuilder:
                                                            (
                                                              context,
                                                              error,
                                                              stackTrace,
                                                            ) {
                                                              return Image.asset(
                                                                AssetsPath
                                                                    .burgerPic,
                                                                fit: BoxFit
                                                                    .cover,
                                                              );
                                                            },
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    data.name ?? 'N/A',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(
                                                    data.shortDescription ??
                                                        'No description',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 10,
                                                      color: Colors.grey,
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
                                                        style:
                                                            GoogleFonts.poppins(
                                                              color:
                                                                  const Color(
                                                                    0xffD61355,
                                                                  ),
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
                                                              builder: (context) =>
                                                                  CartScreen(   cartData: [],
                                                                     
                                                                  ),
                                                            ),
                                                          );
                                                        },
                                                        child: const Icon(
                                                          size: 32,
                                                          Icons.add_circle,
                                                          color: Color(
                                                            0xffD61355,
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
                                      );
                                    },
                                  );
                                default:
                                  return const Center(
                                    child: Text("Something went wrong"),
                                  );
                              }
                            },
                          ),
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
                                builder: (context) => ProductDetailScreen(
                                  pId: '1',
                                  shortDetail: 'data is data and should meat chicken bottle',
                                  imagePath: AssetsPath.burgerPic,
                                  name: 'peporoni',
                                  detail: 'burger is a patty of ground meat, ideally a mix of 80% lean and 20% fat, served between two halves of a bun, with toppings like lettuce, tomato, cheese, and sauces. Key components for a great',
                                  productPrice: '40',
                                  variants: [],
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
                                        color: const Color(0xffD61355),
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
        ],
      ),
    );
  }
}
