import 'package:frontend/App2/Data/Network/Services/get_request_service.dart';
import 'package:frontend/App2/Data/Network/interfaces/get_request_interface.dart';
import 'package:frontend/App2/Data/Responses/api_response.dart';
import 'package:frontend/App2/Data/api_exceptions.dart';
import 'package:frontend/App2/MVVM/Model/products.dart';
import 'package:frontend/App2/Resources/app_url.dart';

class ProductsRepo {
  final GetRequestInterface _getData = GetRequestService();

  Future<ApiResponse<List<Products>>> getProducts(String Id) async {
    try {
      final List<Products> list = [];
    final response = await _getData.getDataRequest("${AppUrl.get_product_list_by_category_id}$Id");
    if (response != null && response['products'] != null) {
      for(var item in response['products']){
        var data = Products.fromJson(item);
        list.add(data);
      } 
      return ApiResponse.success(list);
    }
    return ApiResponse.error(response['message'] ?? 'no product found');
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