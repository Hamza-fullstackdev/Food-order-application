import 'package:flutter/material.dart';
import 'package:frontend/Resources/assetsPaths/assetsPath.dart';

class ProductDetailScreen extends StatefulWidget {
  final String imagePath;
  const ProductDetailScreen({super.key, required this.imagePath});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  List<String> items = ["Burger", "Pizza", "Sandwich"];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 400,
            width: double.infinity,
            decoration: BoxDecoration(color: Color(0xffDC8CB1)),
            child: Image.asset(
              widget.imagePath,
              height: 200,
              filterQuality: FilterQuality.high,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
