import 'package:flutter/material.dart';
import 'package:frontend/App2/Data/Responses/status.dart';
import 'package:frontend/App2/MVVM/ViewModel/product_provider.dart';
import 'package:frontend/App2/Widgets/Common/app_contants.dart';
import 'package:frontend/App2/Widgets/Common/common_button.dart';
import 'package:frontend/App2/Widgets/Common/text_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class ProductDetail extends StatefulWidget {
  final String imagePath;

  const ProductDetail({super.key, required this.imagePath});

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
      Provider.of<ProductProvider>(
        context,
        listen: false,
      ).getSingleProduct(id: widget.imagePath);
      // openBottomSheet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentGeometry.directional(0, 0.9),
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Column(
                  children: [
                    Consumer<ProductProvider>(
                      builder: (context, value, child) {
                        if (value.singleProductApiResponse.status ==
                                Status.Loading ||
                            value.singleProductApiResponse.status ==
                                Status.NotStarted) {
                          return Center(child: CircularProgressIndicator());
                        } else if (value.singleProductApiResponse.status ==
                            Status.Error) {
                          return Center(
                            child: Text(value.singleProductApiResponse.message!),
                          );
                        }
                        return Image.network(
                          width: MediaQuery.of(context).size.width,
                          value.products.image!,
                          fit: BoxFit.fitWidth,
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Consumer<ProductProvider>(
                        builder: (context, value, child) {
                          if (value.singleProductApiResponse.status ==
                                  Status.Loading ||
                              value.singleProductApiResponse.status ==
                                  Status.NotStarted) {
                            return Center(child: CircularProgressIndicator());
                          } else if (value.singleProductApiResponse.status ==
                              Status.Error) {
                            return Center(
                              child: Text(
                                value.singleProductApiResponse.message!,
                              ),
                            );
                          }
                          return Column(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                    value.products.name!,
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
                                  TextView(
                                    text: "4,8 Rating",
                                    color: Colors.grey[400],
                                  ),
                                  SizedBox(width: 20),
                                  Icon(
                                    Icons.shopping_bag_outlined,
                                    color: AppContants.redColor,
                                  ),
                                  TextView(
                                    text: "4,8 Rating",
                                    color: Colors.grey[400],
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              ReadMoreText(
                                value.products.description!,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 16),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    value.products.variantGroups?.length ?? 0,
                                itemBuilder: (context, index) {
                                  final variations =
                                      value.products.variantGroups![index];
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextView(
                                        text: variations.name ?? "N/A",
                                        color: AppContants.redColor,
                                        size: 22,
                                        weight: 600,
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            variations.options?.length ?? 0,
                                        itemBuilder: (context, i) {
                                          final selectedValue = value
                                              .getSelectedOption(
                                                variations.name ?? "",
                                              );
                                          return variations.maxSelectable == 1
                                              ? RadioListTile<String?>(
                                                  activeColor:
                                                      AppContants.redColor,
                                                  radioScaleFactor: 0.7,
                                                  title: TextView(
                                                    text:
                                                        "${variations.options![i].name} (${variations.options![i].price})",
                                                    color: AppContants.blackColor,
                                                    size: 16,
                                                    weight: 400,
                                                  ),
                                                  value:
                                                      variations.options![i].sId,
                                                  groupValue: selectedValue,
                                                  onChanged: (selectedId) {
                                                    value.selectSingleOption(
                                                      variations.name!,
                                                      selectedId!,
                                                    ); // ✅ update provider
                                                  },
                                                )
                                              : CheckboxListTile(
                                                  activeColor:
                                                      AppContants.redColor,
                                                  title: TextView(
                                                    text:
                                                        "${variations.options![i].name} (${variations.options![i].price})",
                                                    color: AppContants.blackColor,
                                                    size: 16,
                                                    weight: 400,
                                                  ),
                        
                                                  value: value.isChecked(
                                                    variations.name!,
                                                    variations.options![i].sId!,
                                                  ),
                                                  onChanged: (checked) {
                                                    value.toggleCheckbox(
                                                      variations.name!,
                                                      variations.options![i].sId!,
                                                      checked!,
                                                    );
                                                  },
                                                );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 0,
              child: CommonButton(
                color: AppContants.redColor,
                width: 326,
                height: 57,
                onPressed: () {
                  
                },
                child: TextView(
                  text: "Check out",
                  color: AppContants.whiteColor,
                  weight: 500,
                  textAlignment: true,
                ),
              ),
            ),
          ],
        ),
      ),
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
