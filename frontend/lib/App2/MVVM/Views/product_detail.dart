
import 'package:flutter/material.dart';
import 'package:frontend/App2/Data/Responses/status.dart';
import 'package:frontend/App2/MVVM/ViewModel/product_detail_view_model.dart';
import 'package:frontend/App2/MVVM/Views/cart_screen.dart';
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
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductDetailViewModel>(
      context,
      listen: false,
    ).getSingleProduct(id: widget.imagePath);
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        
                child: Consumer<ProductDetailViewModel>(
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
        return Stack(
          alignment: AlignmentGeometry.directional(0, 0.98),
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100),
                    child: Column(
                      children: [
                        Image.network(
                          width: MediaQuery.of(context).size.width,
                          value.products.image!,
                          fit: BoxFit.fitWidth,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                    value.products.variantGroups?.length ?? 0,
                                itemBuilder: (context, index) {
                                  final variations =
                                      value.products.variantGroups![index];
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                    color:
                                                        AppContants.blackColor,
                                                    size: 16,
                                                    weight: 400,
                                                  ),
                                                  value: variations
                                                      .options![i]
                                                      .sId,
                                                  groupValue: selectedValue,
                                                  onChanged: (selectedId) {
                                                    value.selectSingleOption(
                                                      variations.name!,
                                                      selectedId!,
                                                    );
                                                  },
                                                )
                                              : CheckboxListTile(
                                                  activeColor:
                                                      AppContants.redColor,
                                                  title: TextView(
                                                    text:
                                                        "${variations.options![i].name} (${variations.options![i].price})",
                                                    color:
                                                        AppContants.blackColor,
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
                                                      variations
                                                          .options![i]
                                                          .sId!,
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
                          ),
                        ),
                      ],
                    )
                 
              ),
            ),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 0,
                  child: Consumer<ProductDetailViewModel>(builder: (context, value, child) => CommonButton(
                      color: AppContants.redColor,
                      width: 326,
                      height: 57,
                      onPressed: () {
                        final valid = value.validateSelections(
                          value.products.variantGroups!,
                        );
                        if (!valid) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: TextView(
                                text: "Please select all required options.",
                                color: AppContants.whiteColor,
                                weight: 700,
                              ),
                              backgroundColor: AppContants.redColor,
                            ),
                          );
                          return;
                        }
                        value.selectOption(
                          value.products.variantGroups!,
                          value.products.sId!,
                        );
                      },
                      child: Consumer<ProductDetailViewModel>(
                        builder: (context, value, child) {
                          if (value.cartApiResponse.status == Status.Success) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CartScreen(),
                              ),
                            );
                          } else if (value.cartApiResponse.status ==
                              Status.Error) {
                              
                            return TextView(text: "Retry Cart",);
                          } else if (value.cartApiResponse.status ==
                              Status.Loading) {
                            return Center(child: CircularProgressIndicator(
                              padding: EdgeInsets.all(0),
                            ));
                          }
                          return TextView(
                            text: "Check out",
                            color: AppContants.whiteColor,
                            weight: 500,
                            textAlignment: true,
                          );
                        },
                      ),
                    ),
                  )
                
            ),
          ],
        );
  })),
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
