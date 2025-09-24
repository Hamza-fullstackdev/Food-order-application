import 'package:flutter/material.dart';
import 'package:frontend/App/MVVM/views/cart_Screen.dart';
import 'package:frontend/Repos/product_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final String imagePath;
  const DetailScreen({super.key, required this.imagePath});

  @override
  State<DetailScreen> createState() => _DetailScreen();
}

class _DetailScreen extends State<DetailScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
      final provider = Provider.of<ProductProvider>(context);
      return Container(
        height: 500,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: FutureBuilder(
          future: provider.getSingleProduct(widget.imagePath),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return CircularProgressIndicator();
            };
            return Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // upper wali line
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    height: 4,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.pink[100],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
          
                Row(
                  children: [
                    Container(
                      height: 35,
                      width: 90,
                      decoration: BoxDecoration(
                        color: const Color(0xffFFE5E5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Popular',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xffD61355),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: const Color(0xffFFE5E5),
                      child: const Icon(
                        Icons.location_on_rounded,
                        color: Color(0xffD61355),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(0xffE5E5E5),
                      child: Icon(Icons.favorite, color: Colors.black),
                    ),
                  ],
                ),
          
                const SizedBox(height: 20),
          
                Text(
                  provider.products.name!,
                  style: GoogleFonts.poppins(
                    fontSize: 27,
                    fontWeight: FontWeight.w600,
                  ),
                ),
          
                const SizedBox(height: 15),
          
                Row(
                  children: [
                    const Icon(
                      Icons.star_half_sharp,
                      color: Colors.amber,
                      size: 18,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '4.8 Rating',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(width: 25),
                    const Icon(
                      Icons.shopping_bag,
                      color: Color(0xffD61355),
                      size: 18,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '7000+ Orders',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
          
                const SizedBox(height: 20),
          
                Text(
                  
                  provider.products.description!,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
          
                const Spacer(),
          
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: const Color(0xffD61355),
                    minimumSize: const Size(double.infinity, 60),
                  ),
                  child: Text(
                    'Add To Chart',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
          }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          FutureBuilder(
            future: productProvider.getSingleProduct(widget.imagePath),
            builder: (context,snap) {
              if(snap.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              return Container(
              height: 400,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xffFFC1E3), Color(0xffDC8CB1)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Image.network(productProvider.products.image!, fit: BoxFit.contain),
            );
            }
          ),
        ],
      ),
    );
  }
}
