// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:frontend/MVVM/ViewModel/address_provider.dart';
import 'package:frontend/MVVM/models/address_model.dart';
import 'package:frontend/Resources/app_colors.dart';
import 'package:frontend/Widgets/common_button.dart';
import 'package:frontend/Widgets/text_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  late final GoogleMapController? _mapController;
  LatLng? latLng;
  bool _isEdit = false;
  int? _index;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final args = ModalRoute.settingsOf(context)!.arguments as List;
      latLng = args[0] as LatLng;
      _isEdit = args[1] as bool;
      _index = args[2] as int?;

      final provider = Provider.of<AddressProvider>(context, listen: false);
      if (latLng == null) {
        await provider.getSelectedPosition(
          provider.latLng.latitude,
          provider.latLng.longitude,
        );
      } else {
        await provider.getSelectedPosition(latLng!.latitude, latLng!.longitude);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _mapController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Consumer<AddressProvider>(
                  builder: (context, value, child) => Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(color: AppColors.lightGreyColor2),
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      onTap: (argument) async {
                        await value.getSelectedPosition(
                          argument.latitude,
                          argument.longitude,
                        );
                        _mapController?.animateCamera(
                          CameraUpdate.newLatLngZoom(argument, 16),
                          duration: Duration(seconds: 1),
                        );
                      },
                      initialCameraPosition: CameraPosition(
                        target: latLng ?? value.latLng,
                        zoom: 16.0,
                      ),
                      markers: {
                        Marker(
                          markerId: MarkerId("UserLocation"),
                          position: value.latLng,
                        ),
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.lightBlackColor,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Consumer<AddressProvider>(
                  builder: (context, value, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextViewNormal(text: 'Address'),
                      SizedBox(height: 10),
                      Container(
                        height: 57,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: AppColors.lightGreyColor2,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: TextViewNormal(
                            align: TextAlign.center,
                            text: value.selectedAddress,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextViewNormal(text: 'Label As'),
                      SizedBox(height: 10),
                      Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.center,
                        spacing: 14,
                        children: value.labelList.map((labelId) {
                          final bool selectedLabel =
                              value.selectedLabel == labelId;
                          return GestureDetector(
                            onTap: () => value.updateLabel(labelId),
                            child: Container(
                              width: MediaQuery.widthOf(context) * 0.25,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: selectedLabel
                                    ? AppColors.orangeColor
                                    : AppColors.greyColorlight,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: TextViewNormal(
                                  text: labelId,
                                  colors: AppColors.whiteColor,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 20),
                      Spacer(flex: 1),
                      ButtonContainerFilled(
                        width: MediaQuery.of(context).size.width,
                        function: () async {
                          if (_isEdit) {
                            await value.updateAddress(
                              _index!,
                              AddressModel(
                                streetAddress: value.selectedAddress,
                                latLng: value.latLng,
                                addressType: AddressTypeExtension.fromString(
                                  value.selectedLabel,
                                ),
                              ),
                            );
                          } else {
                            await value.setAddress(
                              AddressModel(
                                streetAddress: value.selectedAddress,
                                latLng: value.latLng,
                                addressType: AddressTypeExtension.fromString(
                                  value.selectedLabel,
                                ),
                              ),
                            );
                          }

                          Navigator.pop(context);
                        },
                        child: TextViewNormal(
                          text: 'Save location',
                          colors: AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
