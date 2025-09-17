import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final String imagePath;
  const ProductDetailScreen({super.key, required this.imagePath});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> items = ["Burger", "Pizza", "Sandwich"];
  int selectedIndex = 0;
  PersistentBottomSheetController? _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      openBottomSheet();
    });
  }

  void openBottomSheet() {
    _controller ??= _scaffoldKey.currentState!.showBottomSheet((context) {
      return Container(
        height: 500,
        decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 👇 Ye upar wali grey line (handle)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            const SizedBox(height: 10),
            const Text(
              'Product Detail',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),
            const Text('yahan tum apna content daal sakte ho...'),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 400,
            width: double.infinity,
            decoration: const BoxDecoration(color: Color(0xffDC8CB1)),
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
