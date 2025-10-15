import 'package:flutter/widgets.dart';
import 'package:frontend/App2/Data/Responses/api_response.dart';
import 'package:frontend/App2/Data/Responses/status.dart';
import 'package:frontend/App2/MVVM/Model/cart_models.dart';
import 'package:frontend/App2/Repository/cart_repo.dart';

class CartViewModel extends ChangeNotifier {
  ApiResponse _cartProductsResponse = ApiResponse.loading();
  ApiResponse get cartProductsResponse => _cartProductsResponse;

  int _totalPrice = 0;

  List<int> itemsPrices = [];
  List<int> itemsQuantity = [];

  final List<CartItems> _cartItems = [];
  List<CartItems> get cartItems => _cartItems;

  int get subTotalPrice => _totalPrice;
  final _cartRepo = CartRepo();

  void updateQuantity({
    required int quantity,
    required int index,
    required int price,
    required bool isAddition,
  }) {
    if (isAddition) {
      itemsQuantity[index] = itemsQuantity[index] + 1;
      itemsPrices[index] = price * itemsQuantity[index];

      calculateTotalPrice();
    } else {
      if (itemsQuantity[index] > 1) {
        itemsQuantity[index] = itemsQuantity[index] - 1;
        itemsPrices[index] = price * itemsQuantity[index];

        calculateTotalPrice();
      }
    }
  }

  void calculateTotalPrice() {
    _totalPrice = 0;
    for (var value in itemsPrices) {
      _totalPrice = _totalPrice + value;
    }
    notifyListeners();
  }

  Future<void> getCartProducts() async {
    try {
      _totalPrice = 0;
      _cartItems.clear();
      _cartProductsResponse = ApiResponse.loading();
      notifyListeners();
      _cartProductsResponse = await _cartRepo.getCartProducts();
      if (_cartProductsResponse.status == Status.Success) {
        _cartItems.addAll(_cartProductsResponse.data);
        for (var element in _cartItems) {
          itemsPrices.add(element.itemTotal!);
          itemsQuantity.add(element.quantity!);
          _totalPrice = _totalPrice + element.itemTotal!;
        }
        notifyListeners();
      }
    } catch (e) {
      _cartProductsResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
