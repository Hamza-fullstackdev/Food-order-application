import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart'
    // show Stripe, SetupPaymentSheetParameters;
import 'package:frontend/DataLayer/Response/api_responces.dart';
import 'package:frontend/MVVM/models/cart_model.dart';
import 'package:frontend/Repository/cart_repo.dart';
import 'package:frontend/Resources/status.dart';

class CartsProvider extends ChangeNotifier {
  final CartRepo _cartRepo = CartRepo();

  ApiResponces _addtoCartResponse = ApiResponces();
  ApiResponces _getAllCartResponse = ApiResponces();
  ApiResponces _removeItemResponse = ApiResponces();
  ApiResponces _updateCartResponse = ApiResponces();
  ApiResponces _stripeResponse = ApiResponces();

  ApiResponces get addtoCartResponse => _addtoCartResponse;
  ApiResponces get removeItemResponse => _removeItemResponse;
  ApiResponces get updateCartResponse => _updateCartResponse;
  ApiResponces get getAllCartResponse => _getAllCartResponse;
  ApiResponces get stripeResponse => _stripeResponse;

  bool _isEditing = false;
  int _totalPrice = 0;

  final Map<int, int> _quantity = {}; // index → quantity
  final Map<int, int> _price =
      {}; // index → total product price including variants

  int get totalPrice => _totalPrice;
  bool get isEditing => _isEditing;

  Map<int, int> get quantity => _quantity;
  Map<int, int> get price => _price;

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

    if (_getAllCartResponse.status == ResponseStatus.success) {
      List<CartModel> cartList = _getAllCartResponse.data!;

      _quantity.clear();
      _price.clear();

      for (int i = 0; i < cartList.length; i++) {
        CartModel item = cartList[i];

        _quantity[i] = item.quantity ?? 1;

        _price[i] = 0;
        if (item.product?.variantGroups != null) {
          for (var group in item.product!.variantGroups!) {
            for (Options option in group.options ?? []) {
              _price[i] = (_price[i] ?? 0) + (option.price ?? 0);
            }
          }
        }
      }

      calculateTotal();
    }

    notifyListeners();
  }

  Future<void> removeFromCart(String id) async {
    _removeItemResponse = ApiResponces.loading();
    notifyListeners();

    _removeItemResponse = await _cartRepo.removeItemFromCart(id);

    if (_removeItemResponse.status == ResponseStatus.success) {
      await getCarts();
    }

    notifyListeners();
  }

  Future<void> updateCart(String cartItemId, int qty) async {
    _updateCartResponse = ApiResponces.loading();
    notifyListeners();

    _updateCartResponse = await _cartRepo.updateCart(cartItemId, qty);

    notifyListeners();
  }

  void increment(String cartItemId, int index) {
    _quantity[index] = (_quantity[index] ?? 1) + 1;
    calculateTotal();
    updateCart(cartItemId, _quantity[index]!);
  }

  void decrement(String cartItemId, int index) {
    if ((_quantity[index] ?? 1) > 1) {
      _quantity[index] = (_quantity[index] ?? 1) - 1;
      calculateTotal();
      updateCart(cartItemId, _quantity[index]!);
    }
  }

  void updateQuntity(int qty, int index) {
    _quantity[index] = qty;
    calculateTotal();
  }

  void calculateTotal() {
    if (_getAllCartResponse.data == null) return;

    _totalPrice = 0;

    for (int i = 0; i < _price.length; i++) {
      int qty = _quantity[i] ?? 1;
      int itemPrice = _price[i] ?? 0;

      _totalPrice += itemPrice * qty;
    }

    notifyListeners();
  }

  Future<dynamic> setUpPayment() async {
    try {
      await getSecretKey(totalPrice.toDouble());
      if (stripeResponse.status == ResponseStatus.success) {
        // final String secretKey = stripeResponse.data!;
        // // await Stripe.instance.initPaymentSheet(
        // //   paymentSheetParameters: SetupPaymentSheetParameters(
        // //     merchantDisplayName: 'Flutter App',
        // //     paymentIntentClientSecret: secretKey,
        // //     style: ThemeMode.system,
        // //   ),
        // // );
        // await Stripe.instance.presentPaymentSheet();

        return true;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> getSecretKey(double amount) async {
    _stripeResponse = ApiResponces.loading();
    notifyListeners();
    _stripeResponse = await _cartRepo.getSecretKey(amount);
    notifyListeners();
  }

}
