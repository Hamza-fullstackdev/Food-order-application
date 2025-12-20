// ignore_for_file: curly_braces_in_flow_control_structures, unused_field

import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:frontend/MVVM/ViewModel/payment_provider.dart';
import 'package:frontend/MVVM/views/edit_text.dart';
import 'package:frontend/Resources/app_colors.dart';
import 'package:frontend/Widgets/common_button.dart';
import 'package:frontend/Widgets/text_view.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class AddCard extends StatefulWidget {
  const AddCard({super.key});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  late final TextEditingController _nameController;
  late final TextEditingController _cardNumController;
  late final TextEditingController _expireDateController;
  late final TextEditingController _cvcController;
  late final GlobalKey<FormState> _formKey;

  final MaskTextInputFormatter _expiryFormatter = MaskTextInputFormatter(
    mask: '##/##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final _cardFormatter = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _cardNumController = TextEditingController();
    _expireDateController = TextEditingController();
    _cvcController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cardNumController.dispose();
    _expireDateController.dispose();
    _cvcController.dispose();
    super.dispose();
  }

  String? validateExpiry(String? value) {
    if (value == null || value.isEmpty) return 'Expiry date is required';
    if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) return 'Enter a valid MM/YY';

    final parts = value.split('/');
    final month = int.tryParse(parts[0]);
    final year = int.tryParse(parts[1]);

    if (month == null || month < 1 || month > 12)
      return 'Month must be between 01 and 12';

    if (year == null || year < 25 || year > 50)
      return 'Year must be between 25 and 50';

    return null;
  }

  String? validateCardNumber(String? value) {
    if (value == null || value.isEmpty) return 'Card number is required';
    if (value.replaceAll(' ', '').length != 19)
      return 'Card number must be 16 digits';
    return null;
  }

  String? validateCVC(String? value) {
    if (value == null || value.isEmpty) return 'CVC is required';
    if (value.length != 3) return 'CVC must be 3 digits';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.lightGreyColor2,
                          child: TextViewNormal(text: 'x', isBold: true),
                        ),
                      ),
                      TextViewNormal(
                        text: 'Add Card',
                        size: 16,
                        colors: AppColors.blackColor,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        

                        TextViewNormal(
                          text: 'CARD HOLDER NAME',
                          size: 14,
                          colors: AppColors.darkGreyColor,
                        ),
                        SizedBox(height: 5),
                        
                        EditTextCardForm(
                          hintMessage: 'Enter the name on your card',
                          controller: _nameController,
                          errorMessage: 'Enter card holder name',
                        ),
                        SizedBox(height: 10),
                        TextViewNormal(
                          text: 'CARD NUMBER',
                          size: 14,
                          colors: AppColors.darkGreyColor,
                        ),
                        SizedBox(height: 5),
                        EditTextCardForm(
                          hintMessage: '1234 5678 9012 3456',
                          controller: _cardNumController,
                          errorMessage: 'Card number is required',
                        ),
                        SizedBox(height: 10),
                        TextViewNormal(
                          text: 'EXPIRE DATE',
                          size: 14,
                          colors: AppColors.darkGreyColor,
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'MM/YY',
                            hintStyle: TextStyle(
                              color: AppColors.darkGreyColor,
                            ),
                            filled: true,
                            fillColor: AppColors.lightGreyColor2,
                            counterText: "",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: AppColors.orangeColor,
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'Expiry date is required';

                            final parts = value.split('/');
                            if (parts.length != 2) return 'Invalid format';

                            final month = int.tryParse(parts[0]);
                            final year = int.tryParse(parts[1]);

                            if (month == null || month < 1 || month > 12) {
                              return 'Month must be between 01 and 12';
                            }

                            if (year == null || year < 25) {
                              // assuming 2023 as minimum
                              return 'Year cannot be in the past';
                            }

                            if (year > 99)
                              return 'Invalid year'; // optional, depends on your format

                            return null; // valid
                          },
                        ),
                        SizedBox(height: 10),
                        TextViewNormal(
                          text: 'CVC',
                          size: 14,
                          colors: AppColors.darkGreyColor,
                        ),
                        SizedBox(height: 5),
                        EditTextCardForm(
                          hintMessage: '3-digit code (back of card)',
                          controller: _cvcController,
                          errorMessage: 'CVC is required',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Consumer<PaymentMethodsProvider>(
                  builder: (context, value, child) => ButtonContainerFilled(
                    width: MediaQuery.of(context).size.width,
                    function: () {
                      if (_formKey.currentState!.validate()) {
                        // value.addNewCard(
                        //   'Visa',
                        //   _nameController.,
                        //   _cardNumController.text,
                        //   _expireDateController.text,
                        //   _cvcController.text,
                        // );
                        Navigator.pop(context);
                      }
                    },
                    child: TextViewNormal(
                      text: 'Add & Make Payment',
                      colors: AppColors.whiteColor,
                    ),
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