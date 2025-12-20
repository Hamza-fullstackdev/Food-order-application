// ignore_for_file: unused_field, deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/MVVM/ViewModel/order_provider.dart';
import 'package:frontend/Resources/app_colors.dart';
import 'package:frontend/Resources/app_routes.dart';
import 'package:frontend/Resources/assetsPath.dart';
import 'package:frontend/Resources/status.dart';
import 'package:frontend/Widgets/text_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({super.key});

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  late GoogleMapController _mapController;
  LatLng _user = const LatLng(30.6667, 73.1000);
  final LatLng _resturant = const LatLng(30.6726980, 73.1214628);


  void _onMapCreated(GoogleMapController mapController) {
    _mapController = mapController;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<OrderProvider>(context, listen: false);

      await provider.getRoutes(
        _resturant,
        _user,
        'eyJvcmciOiI1YjNjZTM1OTc4NTExMTAwMDFjZjYyNDgiLCJpZCI6IjEwMDhlOGUzYjFmMDQ0OGZiMzE4ZmQ5OTg0YzVkYTU3IiwiaCI6Im11cm11cjY0In0=',
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: AppColors.lightGreyColor2,
              child: Consumer<OrderProvider>(
                builder: (context, value, child) {
                  final polylinePoints =
                      value.routesResponse.status == ResponseStatus.success
                      ? value.routesResponse.data ?? []
                      : [_resturant, _user];
                  return GoogleMap(
                    onMapCreated: _onMapCreated,
                    onTap: (argument) {
                      setState(() async {
                        _user = argument;
                        _mapController.moveCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(target: _user, zoom: 16.0),
                          ),
                        );
                        await value.getRoutes(
                          _resturant,
                          argument,
                          'eyJvcmciOiI1YjNjZTM1OTc4NTExMTAwMDFjZjYyNDgiLCJpZCI6IjEwMDhlOGUzYjFmMDQ0OGZiMzE4ZmQ5OTg0YzVkYTU3IiwiaCI6Im11cm11cjY0In0=',
                        );
                      });
                    },

                    polylines: {
                      Polyline(
                        polylineId: PolylineId("PolyLine"),
                        color: AppColors.orangeColor,
                        points: polylinePoints,
                        width: 5,
                        startCap: Cap.roundCap,
                        endCap: Cap.squareCap,
                      ),
                    },
                    markers: {
                      Marker(markerId: MarkerId('Food App'), position: _user),
                      Marker(
                        markerId: MarkerId('Zaika Hub'),
                        position: _resturant,
                        icon: AssetMapBitmap(
                          AssetsPath.burgerPic,
                          width: 20,
                          height: 20,
                        ),
                      ),
                    },
                    circles: {
                      Circle(
                        circleId: CircleId('Zaika Hub'),
                        center: _resturant,
                        radius: 350,
                        strokeWidth: 0,
                        fillColor: AppColors.darkOrangeColor.withOpacity(0.4),
                      ),
                    },
                    buildingsEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: _user,
                      zoom: 16.2,
                    ),
                  );
                },
              ),
            ),
            DraggableScrollableSheet(
              maxChildSize: 0.7,
              initialChildSize: kIsWeb ? 0.25 : 0.15,
              expand: true,
              minChildSize: 0.15,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(16),
                                  height: kIsWeb ? 120 : 60,
                                  width: kIsWeb ? 150 : 70,
                                  decoration: BoxDecoration(
                                    color: AppColors.lightGreyColor2,
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: AssetImage(AssetsPath.foodImg),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 16,
                                    bottom: 16,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextViewNormal(
                                        text: 'Uttora Coffee House',
                                        colors: AppColors.blackColor,
                                        size: 18,
                                      ),

                                      TextViewNormal(
                                        text: 'Orderd at 06 Sept, 10:00pm',
                                        colors: AppColors.darkGreyColor,
                                        size: 14,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                            0.5,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: 2,
                                          itemBuilder: (context, index) {
                                            return TextViewNormal(
                                              text: '2x Burger',
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            TextViewLarge(
                              text: '20 Min',
                              size: 20,
                              isBold: true,
                            ),
                            TextViewNormal(
                              text: 'Estimated delivery time',
                              colors: AppColors.darkGreyColor,
                            ),

                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                    children: [
                                      CircleAvatar(
                                        maxRadius: 12,
                                        backgroundColor: AppColors.orangeColor,
                                        child: Icon(
                                          Icons.check,
                                          color: AppColors.whiteColor,
                                          size: 12,
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                      TextViewNormal(
                                        text: 'Your order has been received',
                                        colors: AppColors.orangeColor,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        maxRadius: 12,
                                        backgroundColor: AppColors.orangeColor,
                                        child: Icon(
                                          Icons.check,
                                          color: AppColors.whiteColor,
                                          size: 12,
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                      Expanded(
                                        child: TextViewNormal(
                                          text:
                                              'The restaurant is preparing your food',
                                          colors: AppColors.orangeColor,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                    children: [
                                      CircleAvatar(
                                        maxRadius: 12,
                                        backgroundColor:
                                            AppColors.darkGreyColor,
                                        child: Icon(
                                          Icons.check,
                                          color: AppColors.whiteColor,
                                          size: 12,
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                      Expanded(
                                        child: TextViewNormal(
                                          text:
                                              'Your order has been picked up for delivery',
                                          colors: AppColors.darkGreyColor,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        maxRadius: 12,
                                        backgroundColor:
                                            AppColors.darkGreyColor,
                                        child: Icon(
                                          Icons.check,
                                          color: AppColors.whiteColor,
                                          size: 12,
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                      TextViewNormal(
                                        text: 'Order arriving soon!',
                                        colors: AppColors.darkGreyColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.12,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 16,
                                  right: 16,
                                  bottom: 16,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: AssetImage(
                                                AssetsPath.profilePic,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextViewNormal(text: 'Robert F.'),
                                            TextViewNormal(
                                              text: 'Courier',
                                              colors: AppColors.darkGreyColor,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              AppColors.orangeColor,

                                          child: IconButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                context,
                                                AppRoutes.callScreen,
                                              );
                                            },
                                            icon: Icon(
                                              Icons.phone_outlined,
                                              shadows: [
                                                Shadow(
                                                  color:
                                                      AppColors.lightGreyColor,
                                                ),

                                                Shadow(
                                                  color:
                                                      AppColors.lightGreyColor2,
                                                ),

                                                Shadow(
                                                  color:
                                                      AppColors.darkGreyColor,
                                                ),
                                              ],
                                              color: AppColors.whiteColor,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 20),

                                        CircleAvatar(
                                          backgroundColor:
                                              AppColors.orangeColor,

                                          child: IconButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                context,
                                                AppRoutes.chatScreen,
                                              );
                                            },
                                            icon: Icon(
                                              Icons.message_outlined,
                                              shadows: [
                                                Shadow(
                                                  color:
                                                      AppColors.lightGreyColor,
                                                ),

                                                Shadow(
                                                  color:
                                                      AppColors.lightGreyColor2,
                                                ),

                                                Shadow(
                                                  color:
                                                      AppColors.darkGreyColor,
                                                ),
                                              ],
                                              color: AppColors.whiteColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Positioned(
              top: 20,
              left: 20,
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.blackColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                  TextViewNormal(
                    text: 'Track Order',
                    size: 16,
                    colors: AppColors.blackColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
