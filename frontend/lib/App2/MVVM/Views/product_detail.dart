import 'package:flutter/material.dart';
import 'package:frontend/App2/MVVM/ViewModel/product_provider.dart';
import 'package:frontend/App2/Widgets/Common/app_contants.dart';
import 'package:frontend/App2/Widgets/Common/text_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatefulWidget {
  final String imagePath;

  ProductDetail({super.key, required this.imagePath});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  PersistentBottomSheetController? _controller;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      openBottomSheet();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      key: _scaffoldKey,

      body: SafeArea(
        child: FutureBuilder(
          future: productProvider.getSingleProduct(widget.imagePath),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text("Error");
            } else {
              return Image.network(
                height: MediaQuery.of(context).size.height * 0.40,
                width: MediaQuery.of(context).size.width,
                productProvider.products.image!,
                fit: BoxFit.fitWidth,
              );
            }
          },
        ),
      ),
    );
  }

  void openBottomSheet() {
    _controller = _scaffoldKey.currentState?.showBottomSheet(
      enableDrag: false,
      showDragHandle: true,
      (context) {
        final provider = Provider.of<ProductProvider>(context);
        return Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container1(
                    width: 90.0,
                    child: TextView(
                      text: 'Popular',
                      size: 12,
                      color: AppContants.redColor,
                      weight: 500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container1(
                        child: Icon(
                          Icons.location_on,
                          color: AppContants.redColor,
                        ),
                      ),
                      SizedBox(width: 10),
                      Container1(
                        color: AppContants.lightGrey,
                        child: Icon(Icons.favorite),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    provider.products.name!,
                    style: GoogleFonts.poppins(
                      fontSize: 27,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  TextView(text: "4,8 Rating", color: Colors.grey[400]),
                  SizedBox(width: 20),
                  Icon(
                    Icons.shopping_bag_outlined,
                    color: AppContants.redColor,
                  ),
                  TextView(text: "4,8 Rating", color: Colors.grey[400]),
                ],
              ),
              SizedBox(height: 16),
              Text(
                provider.products.description!,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true, // ✅ avoid layout issues
                physics: NeverScrollableScrollPhysics(), // ✅ avoids nested scroll conflict
                itemCount: provider.products.variantGroups?.length ?? 0,
                itemBuilder: (context, index) {
                  final group = provider.products.variantGroups![index];
                  if (group == null)
                    return SizedBox.shrink(); // ✅ skip null entry
                  return Text(group.name ?? "Unnamed variant group");
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class Container1 extends StatelessWidget {
  final Widget child;
  final color;
  final width;
  const Container1({
    super.key,
    this.color = const Color(0xffFFE5E5),
    this.width = 35.0,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(child: child),
    );
  }
}
