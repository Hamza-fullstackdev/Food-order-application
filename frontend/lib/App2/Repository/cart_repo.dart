import 'package:frontend/App2/Data/Network/Services/get_request_service.dart';
import 'package:frontend/App2/Data/Responses/api_response.dart';
import 'package:frontend/App2/Data/api_exceptions.dart';
import 'package:frontend/App2/MVVM/Model/cart_models.dart';
import 'package:frontend/App2/Resources/app_url.dart';

class CartRepo {
  final _apiRequest = ApiRequestService();

  Future<ApiResponse<String>> addItemToCart(Map<String, dynamic> body) async {
    try {
      final url = AppUrl.post_add_to_cart;
      final response = await _apiRequest.postDataService(url, body);

      if (response != null && response['message'] != null) {
        return ApiResponse.success(response['message']);
      }
      return ApiResponse.error(response['message']);
    } on InternetException catch (e) {
      return ApiResponse.error(e.toString());
    } on RequestTimeOut catch (e) {
      return ApiResponse.error(e.toString());
    } on ServerException catch (e) {
      return ApiResponse.error(e.toString());
    } on FetchDataException catch (e) {
      return ApiResponse.error(e.toString());
    } catch (e) {
      return ApiResponse.error("Something went wrong: $e");
    }
  }

  Future<ApiResponse<List<CartItems>>> getCartProducts() async {

    try {
      final List<CartItems> cartList = [];
      final url = AppUrl.get_cart_items;
      final response = await _apiRequest.getDataRequest(url);
      if (response != null && response['cartItems'] != null) {
        for (var item in response['cartItems']) {
          final data = CartItems.fromJson(item);
          cartList.add(data);
        }

        return ApiResponse.success(cartList);
      } 
       return ApiResponse.error(response['message'] ?? "Item cart is empty!!");
    } on InternetException catch (e) {
      return ApiResponse.error(e.toString());
    } on RequestTimeOut catch (e) {
      return ApiResponse.error(e.toString());
    } on ServerException catch (e) {
      return ApiResponse.error(e.toString());
    } on FetchDataException catch (e) {
      return ApiResponse.error(e.toString());
    } catch (e) {
      return ApiResponse.error("Something went wrong: $e");
    }
  }
}
