import 'package:frontend/App/Core/Exceptions/exceptions.dart';
import 'package:frontend/App/Core/Responce/api_responce.dart';
import 'package:frontend/App/DataLAYER/Service/productService/productService.dart';
import 'package:frontend/App/MVVM/models/GetProduct_ByCategoryId.dart';
import 'package:frontend/App2/Resources/app_url.dart';

class ProductRepoo {
  ProductRepoo._private();
  static final ProductRepoo instance = ProductRepoo._private();
  factory ProductRepoo() {
    return instance;
  }

  final _productService = ProductService();

  Future<ApiResponce<GetAllProducts>> getAllProducts({
    required String id,
  }) async {
    try {
      if (id.isEmpty) {
        return ApiResponce.error("Category ID is required");
      }
      String url = AppUrl.get_product_list_by_category_id + id;
      final responce = await _productService.getAllProdcuts(url: url);

      return ApiResponce.success(responce);
    } on InternetException catch (e) {
      return ApiResponce.error(e.toString());
    } on RequestTimeOut catch (e) {
      return ApiResponce.error(e.toString());
    } on ServerException catch (e) {
      return ApiResponce.error(e.toString());
    } on FetchDataException catch (e) {
      return ApiResponce.error(e.toString());
    } catch (e) {
      return ApiResponce.error("Something went wrong: $e");
    }
  }
}