// lib/App/MVVM/providers/cart_provider.dart
import 'package:flutter/material.dart';
import 'package:frontend/App/MVVM/models/cartModel.dart';

class CartProvider extends ChangeNotifier {
  final List<CartModel> _cartItems = [];

  List<CartModel> get cartItems => _cartItems;

  void addToCart(CartModel item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void updateQuantity(String pId, int newQuantity) {
    final index = _cartItems.indexWhere((item) => item.pId == pId);
    if (index != -1 && newQuantity > 0) {
      _cartItems[index] = CartModel(
        pId: _cartItems[index].pId,
        image: _cartItems[index].image,
        productName: _cartItems[index].productName,
        productShortDescription: _cartItems[index].productShortDescription,
        productPrice: _cartItems[index].productPrice,
        selectedSize: _cartItems[index].selectedSize,
        selectedOptionalVariants: _cartItems[index].selectedOptionalVariants,
        quantity: newQuantity,
      );
      notifyListeners();
    }
  }

  void removeFromCart(String pId) {
    _cartItems.removeWhere((item) => item.pId == pId);
    notifyListeners();
  }

  double getTotalPrice() {
    return _cartItems.fold(0.0, (total, item) {
      final price = double.tryParse(item.productPrice) ?? 0.0;
      return total + (price * item.quantity);
    });
  }
}