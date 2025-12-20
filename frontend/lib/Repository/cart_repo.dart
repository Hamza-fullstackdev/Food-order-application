import 'package:frontend/DataLayer/Network/Interfaces/cart_interface.dart';
import 'package:frontend/DataLayer/Network/Services/cart_service.dart';
import 'package:frontend/DataLayer/Response/api_responces.dart';
import 'package:frontend/DataLayer/api_exceptions.dart';
import 'package:frontend/MVVM/models/cart_model.dart';
import 'package:frontend/Resources/app_url.dart';

class CartRepo {
  final CartInterface _cartInterface = CartService();

  Future<ApiResponces<bool>> addItemToCart(
    String productId,
    int quantity,
    List<Map<String, dynamic>> selectedOptions,
  ) async {
    try {
      final Map<String, dynamic> body = {
        'productId': productId,
        'quantity': quantity,
        'selectedOptions': selectedOptions,
      };
      final String url = ApiUrl.addItemToCartUrl;
      final data = await _cartInterface.addItemToCart(body, url);

      if (data != null && data['cartItem'] != null) {
        return ApiResponces.success(true);
      }
      return ApiResponces.error(
        data['message'] ?? 'Item is already in the cart',
      );
    } catch (e) {
      if (e is ApiException) {
        return ApiResponces.error(e.message);
      }
      return ApiResponces.error("Unexpected error: ${e.toString()}");
    }
  }

  Future<ApiResponces<List<CartModel>>> getAllCarts() async {
    try {
      final List<CartModel> cartList = [];
      final url = ApiUrl.getAllCartsUrl;
      final data = await _cartInterface.getAllCarts(url);
      if (data != null && data['cartItems'] != null) {
        for (var item in data['cartItems']) {
          cartList.add(CartModel.fromJson(item));
        }
        return ApiResponces.success(cartList);
      }
      return ApiResponces.error(data['message'] ?? 'No Item in the cart');
    } catch (e) {
      if (e is ApiException) {
        return ApiResponces.error(e.message);
      }
      return ApiResponces.error("Unexpected error: ${e.toString()}");
    }
  }

  Future<ApiResponces<bool>> removeItemFromCart(String categoryId) async {
    try {
      final url = '${ApiUrl.removeItemFromCart}$categoryId';
      final data = await _cartInterface.removeItemFromCart(url);
      if (data != null && data['message'] != null) {
        return ApiResponces.success(true);
      }
      return ApiResponces.error(data['message'] ?? 'unable to remove item');
    } catch (e) {
      if (e is ApiException) {
        return ApiResponces.error(e.message);
      }
      return ApiResponces.error("Unexpected error: ${e.toString()}");
    }
  }

  Future<ApiResponces> updateCart(String cartItemId, int quantity) async {
    try {
      final Map<String, dynamic> body = {'quantity': quantity};

      final url = '${ApiUrl.updateCartUrl}$cartItemId';
      final data = await _cartInterface.updateCart(body, url);
      if (data != null && data['message'] != null) {
        return ApiResponces.success(true);
      }
      return ApiResponces.error(data['message'] ?? 'unable to remove item');
    } catch (e) {
      if (e is ApiException) {
        return ApiResponces.error(e.message);
      }
      return ApiResponces.error("Unexpected error: ${e.toString()}");
    }
  }

  Future<ApiResponces<String>> getSecretKey(double amount) async {
    try {
      final Map<String, double> body = {'amount': amount};
      final url = ApiUrl.paymentUrl;
      final data = await _cartInterface.getSecretKey(url, body);
      if (data != null && data['clientSecret'] != null) {
        return ApiResponces.success(data['clientSecret']);
      }
      return ApiResponces.error('Failed to fetch Secret key from backend.');
    } catch (e) {
      if (e is ApiException) {
        return ApiResponces.error(e.message);
      }
      return ApiResponces.error("Unexpected error: ${e.toString()}");
    }
  }
}
