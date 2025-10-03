import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/App/Resources/assetsPaths/assetsPath.dart';
import 'package:frontend/App/MVVM/views/productDetailscreen.dart';
import 'package:google_fonts/google_fonts.dart';

class MealMenuScreen extends StatefulWidget {
  const MealMenuScreen({super.key});

  @override
  State<MealMenuScreen> createState() => _MealMenuScreenState();
}

class _MealMenuScreenState extends State<MealMenuScreen> {
  final List<Map<String, dynamic>> meals = [
    {
      "title": "Chicken Spagetti",
      "subtitle": "1 Big Pack",
      "price": "\$7",
      "image": AssetsPath.burgerDetailPic,
    },
    {
      "title": "Jollof Rice",
      "subtitle": "1 Combo pack",
      "price": "\$10",
      "image": AssetsPath.burgerPic,
    },
    {
      "title": "Fruity Pancakes",
      "subtitle": "Noodle Home",
      "price": "\$12",
      "image": AssetsPath.burgerDetailPic,
    },
    {
      "title": "Pepper Pizza",
      "subtitle": "5kg box of Pizza",
      "price": "\$15",
      "image": AssetsPath.burgerPic,
    },
    {
      "title": "Pepper Pizza",
      "subtitle": "5kg box of Pizza",
      "price": "\$15",
      "image": AssetsPath.burgerPic,
    },
    {
      "title": "Pepper Pizza",
      "subtitle": "5kg box of Pizza",
      "price": "\$15",
      "image": AssetsPath.burgerPic,
    },
    {
      "title": "Pepper Pizza",
      "subtitle": "5kg box of Pizza",
      "price": "\$15",
      "image": AssetsPath.burgerPic,
    },
    {
      "title": "Pepper Pizza",
      "subtitle": "5kg box of Pizza",
      "price": "\$15",
      "image": AssetsPath.burgerPic,
    },
    {
      "title": "Pepper Pizza",
      "subtitle": "5kg box of Pizza",
      "price": "\$15",
      "image": AssetsPath.burgerPic,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F8FE),
      body: Stack(
        children: [
          Positioned(
            top: 24,
            left: -50,
            right: -100,
            child: Image.asset(
              AssetsPath.mealMenuTopPattren,
              height: 240,
              width: MediaQuery.of(context).size.width + 150,
              fit: BoxFit.contain,
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
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
                      const Spacer(),
                      Stack(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xffFFE5E5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                CupertinoIcons.bell,
                                color: const Color(0xffD61355),
                              ),
                            ),
                          ),

                          Positioned(
                            top: 10.4,
                            right: 13.7,
                            child: Container(
                              height: 5.8,
                              width: 5.8,
                              decoration: BoxDecoration(
                                color: const Color(0xffD61355),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: .7,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Meal Menu',
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

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
                    child: TextField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          CupertinoIcons.search,
                          size: 20,
                          color: Colors.black,
                        ),
                        hintText: 'Search',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),

                  const SizedBox(height: 19),

                  Expanded(
                    child: meals.length > 5
                        ? GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.85,
                                  crossAxisSpacing: 2.3,
                                  mainAxisSpacing: 3.6,
                                ),
                            itemCount: meals.length,
                            itemBuilder: (context, index) {
                              final meal = meals[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailScreen(
                                        pId: '0',
                                        shortDetail:  'data is data and should meat chicken bottle',
                                        imagePath: meal["image"],
                                        productPrice: meal['price'],
                                        name: meal['title'],
                                        variants: [],
                                        detail:
                                            'burger is a patty of ground meat, ideally a mix of 80% lean and 20% fat, served between two halves of a bun, with toppings like lettuce, tomato, cheese, and sauces. Key components for a great',
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  elevation: .7,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                            child: Image.asset(
                                              meal["image"],
                                              width: double.infinity,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          meal["title"],
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          meal["subtitle"],
                                          style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            meal["price"],
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
                              );
                            },
                          )
                        : ListView.separated(
                            itemCount: meals.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final meal = meals[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailScreen(
                                        pId: '0',
                                        shortDetail:  'data is data and should meat chicken bottle',
                                        imagePath: meal["image"],
                                        name: meal['tittle'],
                                        productPrice: meal['price'],
                                        detail:
                                            'burger is a patty of ground meat, ideally a mix of 80% lean and 20% fat, served between two halves of a bun, with toppings like lettuce, tomato, cheese, and sauces. Key components for a great',

                                            variants: [],
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  elevation: .7,
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
                                            meal["image"],
                                            height: 80,
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
                                              meal["title"],
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              meal["subtitle"],
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
                                            meal["price"],
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
                              );
                            },
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
