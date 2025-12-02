import 'package:flutter/foundation.dart';
import 'package:frontend/DataLayer/Response/api_responces.dart';
import 'package:frontend/Repository/cart_repo.dart';

class CartsProvider extends ChangeNotifier {
  final CartRepo _cartRepo = CartRepo();

  ApiResponces _addtoCartResponse = ApiResponces();
  ApiResponces _getAllCartResponse = ApiResponces();
  ApiResponces _removeItemResponse = ApiResponces();
  ApiResponces _updateCartResponse = ApiResponces();

  ApiResponces get addtoCartResponse => _addtoCartResponse;
  ApiResponces get removeItemResponse => _removeItemResponse;
  ApiResponces get updateCartResponse => _updateCartResponse;
  ApiResponces get getAllCartResponse => _getAllCartResponse;

  bool _isEditing = false;

  int _price = 0;
  final Map<int, int> _quantity = {};

  int get price => _price;
  bool get isEditing => _isEditing;

  Map<int, int> get quantity => _quantity;

  void setIsEditing() {
    _isEditing = !_isEditing;
    notifyListeners();
  }

  Future<void> setCarts(
    String productId,
    int quantity,
    List<Map<String, dynamic>> selectedOptions,
  ) async {
    _addtoCartResponse = ApiResponces.loading();
    notifyListeners();
    _addtoCartResponse = await _cartRepo.addItemToCart(
      productId,
      quantity,
      selectedOptions,
    );
    notifyListeners();
  }

  Future<void> getCarts() async {
    _getAllCartResponse = ApiResponces.loading();
    notifyListeners();
    _getAllCartResponse = await _cartRepo.getAllCarts();
    notifyListeners();
  }

  Future<void> removeFromCart(String id) async {
    _removeItemResponse = ApiResponces.loading();
    notifyListeners();
    _removeItemResponse = await _cartRepo.removeItemFromCart(id);
    notifyListeners();
  }

  Future<void> updateCart(String cartItemId, int quantity) async {
    _updateCartResponse = ApiResponces.loading();
    notifyListeners();
    _updateCartResponse = await _cartRepo.updateCart(cartItemId, quantity);
    notifyListeners();
  }

  void increment(String cartItemId, int index) {
    _quantity[index] = (_quantity[index] ?? 1) + 1;
    updateCart(cartItemId, _quantity[index]!);

    calculateTotal();
  }

  void decrement(String cartItemId, int index) {
    if ((_quantity[index] ?? 1) > 1) {
      _quantity[index] = (_quantity[index] ?? 1) - 1;
      updateCart(cartItemId, _quantity[index]!);
      calculateTotal();
    }
  }

  void updateQuntity(int quantity, int index) {
    _quantity[index] = quantity;
    calculateTotal();
  }

  void calculateTotal() {
    _price = 0;

    notifyListeners();
  }
}
