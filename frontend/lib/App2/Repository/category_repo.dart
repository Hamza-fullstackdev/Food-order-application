import 'package:frontend/App2/Data/Network/Services/get_request_service.dart';
import 'package:frontend/App2/Data/Network/interfaces/get_request_interface.dart';
import 'package:frontend/App2/Data/Responses/api_response.dart';
import 'package:frontend/App2/Data/api_exceptions.dart';
import 'package:frontend/App2/MVVM/Model/categories.dart';
import 'package:frontend/App2/Resources/app_url.dart';

class CategoryRepo {
  final GetRequestInterface _categoryInterface = GetRequestService();
  Future<ApiResponse<List<Categories>>> getCategory() async {
    try {
      final List<Categories> list = [];

    final result = await _categoryInterface.getDataRequest(AppUrl.get_all_categories_url);

    

    if (result != null && result['categories'] != null){
      list.clear();
      for(var item in result['categories']){
        list.add(Categories.fromJson(item));
      }
      return ApiResponse.success(list); 
    }
    return ApiResponse.error(result['message'] ?? 'No List Found');
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