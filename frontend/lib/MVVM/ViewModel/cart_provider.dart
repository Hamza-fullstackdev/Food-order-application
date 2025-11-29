import 'package:flutter/foundation.dart';
import 'package:frontend/MVVM/models/cartModel.dart' show CartModel;

class CartsProvider extends ChangeNotifier {
  bool _isEditing = false;

  int _price = 0;
  final Map<int, int> _quantity = {};

  final List<CartModel> _cartList = [];

  int get price => _price;
  bool get isEditing => _isEditing;


  List<CartModel> get cartList => _cartList;
  Map<int, int> get quantity => _quantity;

  void setIsEditing(){
    _isEditing = !_isEditing;
    notifyListeners();
  }
  void addToCart(CartModel productModel) {
    _cartList.add(productModel);
    _quantity[_cartList.length - 1] = productModel.quantity;
    calculateTotal();
  }
  void removeToCart(int index) {
    _cartList.removeAt(index);
    calculateTotal();
  }

  void increment(int index) {
    _quantity[index] = (_quantity[index] ?? 1) + 1;
    calculateTotal();
  }

  void decrement(int index) {
    if ((_quantity[index] ?? 1) > 1) {
      _quantity[index] = (_quantity[index] ?? 1) - 1;
      calculateTotal();
    }
  }

  void updateQuntity(int quantity, int index) {
    _quantity[index] = quantity;
    calculateTotal();
  }

  void calculateTotal() {
    _price = 0; 

    for (int i = 0; i < _cartList.length; i++) {
      int qty = _quantity[i] ?? _cartList[i].quantity;
      _price +=  _cartList[i].price * qty;
    }

    notifyListeners();
  }
}