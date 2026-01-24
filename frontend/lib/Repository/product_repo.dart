import 'package:frontend/DataLayer/Network/Interfaces/product_interface.dart';
import 'package:frontend/DataLayer/Network/Services/product_service.dart';
import 'package:frontend/DataLayer/Response/api_responces.dart';
import 'package:frontend/DataLayer/api_exceptions.dart';
import 'package:frontend/MVVM/models/GetProduct_ByCategoryId.dart';
import 'package:frontend/Resources/app_url.dart';

class ProductRepo {
  final ProductInterface _products = ProductService();

  Future<ApiResponces<List<Products>>> getProductsByCategoryId(
    String categoryId,
  ) async {
    try {
      final List<Products> productsList = [];
      final String url = '${ApiUrl.getProductsByCategoryIdUrl}$categoryId';
      final data = await _products.getProductsByCategoryId(url);

      if (data != null && data['products'] != null) {
        for (var item in data['products']) {
          productsList.add(Products.fromJson(item));
        }
        return ApiResponces.success(productsList);
      }
      return ApiResponces.failed(data['message'] ?? 'No product found, please try again later!!');
    } catch (e) {
      if (e is ApiException) {
        return ApiResponces.failed(e.message);
      }
      return ApiResponces.failed("Unexpected error: ${e.toString()}");
    }
  }
}
