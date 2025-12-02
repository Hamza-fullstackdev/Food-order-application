import 'package:frontend/DataLayer/Network/Interfaces/product_interface.dart';
import 'package:frontend/DataLayer/Network/Services/product_service.dart';
import 'package:frontend/DataLayer/Response/api_responces.dart';
import 'package:frontend/DataLayer/api_exceptions.dart';
import 'package:frontend/MVVM/models/GetProduct_ByCategoryId.dart';
import 'package:frontend/Resources/app_url.dart';

class ProductRepo {
  final ProductInterface _products = ProductService();

  Future<ApiResponces<List<Products>>> getProductsByCategoryId(String categoryId) async {
    try {
      final String url = '${ApiUrl.getProductsByCategoryIdUrl}$categoryId';
      final data = await _products.getProductsByCategoryId(url);
      final List<Products> productsList = data['products'];

      return ApiResponces.success(productsList);
    } catch (e) {
      if (e is ApiException) {
        return ApiResponces.error(e.message);
      }
      return ApiResponces.error("Unexpected error: ${e.toString()}");
    }
  }
}