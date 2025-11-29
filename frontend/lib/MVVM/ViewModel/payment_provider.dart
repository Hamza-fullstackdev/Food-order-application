import 'package:flutter/foundation.dart';
import 'package:frontend/MVVM/models/card_model.dart';
import 'package:frontend/MVVM/models/payment_method_model.dart';
import 'package:frontend/Resources/assetsPath.dart';

class PaymentMethodsProvider extends ChangeNotifier {
  int _currentPaymentMethod = 0;
  int _selectedCardIndex = 0;

  final List<PaymentMethodsModel> _paymentMethods = [
    PaymentMethodsModel(cardType: 'Cash', cardLogo: AssetsPath.cashCard),
    PaymentMethodsModel(cardType: 'Visa', cardLogo: AssetsPath.visaCard),
    PaymentMethodsModel(cardType: 'Master', cardLogo: AssetsPath.masterCard),
    PaymentMethodsModel(cardType: 'Paypal', cardLogo: AssetsPath.paypalCard),
  ];
  final List<CardModel> _cardList = [
    CardModel(
      name: 'Fiaz',
      cardType: 'Master',
      cardNum: '4242 4242 4242 4242',
      expDate: '02/29',
      cvcNum: '992',
    ),
    CardModel(
      name: 'Fiaz',
      cardType: 'Visa',
      cardNum: '4242 4242 4242 4242',
      expDate: '02/29',
      cvcNum: '992',
    ),
    CardModel(
      name: 'Fiaz',
      cardType: 'Paypal',
      cardNum: '4242 4242 4242 4242',
      expDate: '02/29',
      cvcNum: '992',
    ),
    CardModel(
      name: 'Fiaz',
      cardType: 'Master',
      cardNum: '4242 4242 4242 4242',
      expDate: '02/29',
      cvcNum: '992',
    ),
  ];

  final List<CardModel> _filteredList = [];
  List<CardModel> get cardList => _filteredList;
  List<PaymentMethodsModel> get paymentMethods => _paymentMethods;
  int get selectedCardIndex => _selectedCardIndex;
  int get currentPaymentMethod => _currentPaymentMethod;

  void setSelectedCard(int i) {
    _selectedCardIndex = i;
    notifyListeners();
  }

  void setSelectedPayementMethod(int i) {
    _currentPaymentMethod = i;
    _selectedCardIndex = 0;
    notifyListeners();
  }

  void addCard(CardModel cardModel) {
    _cardList.add(cardModel);
    notifyListeners();
  }

  void filterList(String cardType) {
    _filteredList.clear();
    _filteredList.addAll(
      _cardList.where((value) => value.cardType == cardType),
    );
    notifyListeners();
  }

  String maskCardNumber(String num) {
    if (num.length < 3) {
      return num;
    } else {
      String newNum = num.substring(num.length - 3);
      return '**** **** **** *$newNum';
    }
  }

  void addNewCard(
    String cardType,
    String cardHolderName,
    String cardNum,
    String expDate,
    String cvcNum,
  ) {
    _cardList.add(
      CardModel(
        name: cardHolderName,
        cardNum: cardNum,
        expDate: expDate,
        cvcNum: cvcNum,
        cardType: cardType,
      ),
    );
    filterList(cardType);
    notifyListeners();
  }
}