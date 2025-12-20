import 'package:flutter/material.dart';
import 'package:frontend/MVVM/ViewModel/address_provider.dart';
import 'package:frontend/MVVM/models/address_model.dart';
import 'package:frontend/Resources/app_colors.dart';
import 'package:frontend/Resources/app_routes.dart';
import 'package:frontend/Widgets/common_button.dart';
import 'package:frontend/Widgets/text_view.dart';
import 'package:provider/provider.dart';

class AllAddressesPage extends StatefulWidget {
  const AllAddressesPage({super.key});

  @override
  State<AllAddressesPage> createState() => _AllAddressesPageState();
}

class _AllAddressesPageState extends State<AllAddressesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.lightGreyColor2,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new),
                    ),
                  ),
                  const SizedBox(width: 20),
                  TextViewNormal(
                    text: "My Address",
                    colors: AppColors.blackColor,
                    isBold: true,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Expanded(
                child: Consumer<AddressProvider>(
                  builder: (context, value, child) => ListView.builder(
                    itemCount: value.addressList.length,
                    itemBuilder: (context, index) {
                      final AddressModel currentAddress =
                          value.addressList[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.lightGreyColor2,
                          borderRadius: BorderRadius.circular(10),
                        ),

                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: AppColors.whiteColor,
                              child: Icon(
                                currentAddress.addressType == AddressType.home
                                    ? Icons.home_outlined
                                    : currentAddress.addressType ==
                                          AddressType.work
                                    ? Icons.work_outline
                                    : Icons.location_on_outlined,
                                color:
                                    currentAddress.addressType ==
                                        AddressType.home
                                    ? Colors.blueAccent
                                    : currentAddress.addressType ==
                                          AddressType.work
                                    ? Colors.deepPurple
                                    : Colors.blueGrey,
                              ),
                            ),
                            const SizedBox(width: 16),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextViewNormal(
                                        text: value
                                            .addressList[index]
                                            .addressType!
                                            .name,
                                        colors: AppColors.blackColor,
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                context,
                                                AppRoutes.addAddressPage,
                                                arguments: [
                                                  value
                                                      .addressList[index]
                                                      .latLng,
                                                  true,
                                                  index,
                                                ],
                                              );
                                            },
                                            icon: Icon(
                                              Icons.edit,
                                              color: AppColors.orangeColor,
                                              size: 22,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              value.removeAddress(index);
                                            },
                                            icon: Icon(
                                              Icons.delete_outline_rounded,
                                              color: AppColors.orangeColor,
                                              size: 22,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  TextViewNormal(
                                    text:
                                        value.addressList[index].streetAddress,
                                    colors: AppColors.darkGreyColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Consumer<AddressProvider>(
                builder: (context, value, child) => ButtonContainerFilled(
                  function: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.addAddressPage,
                      arguments: [value.latLng, false,null],
                    );
                  },
                  height: 57,
                  width: MediaQuery.of(context).size.width,
                  child: TextViewNormal(
                    text: 'Add Address',
                    colors: AppColors.whiteColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
