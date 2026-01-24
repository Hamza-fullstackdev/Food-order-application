import 'package:frontend/DataLayer/Network/Interfaces/category_interface.dart';
import 'package:frontend/DataLayer/Network/Services/category_service.dart';
import 'package:frontend/DataLayer/Response/api_responces.dart';
import 'package:frontend/DataLayer/api_exceptions.dart';
import 'package:frontend/MVVM/models/categoryModle.dart';
import 'package:frontend/Resources/app_url.dart';

class CategoryRepo {
  final CategoryInterface _categoriesInterface = CategoryService();

  Future<ApiResponces<List<Categories>>> getCategories() async {
    try {
      final List<Categories> categoriesList = [];
      final String url = ApiUrl.allCategoriesUrl;
      final data = await _categoriesInterface.getCategories(url);
      if (data != null && data['categories'] != null) {
        for (var item in data['categories']) {
          categoriesList.add(Categories.fromJson(item));
        }
      return ApiResponces.success(categoriesList);

      }
      return ApiResponces.failed(data['message'] ?? "No Category found, please try again!!");

    } catch (e) {
      if (e is ApiException) {
        return ApiResponces.failed(e.message);
      }
      return ApiResponces.failed("Unexpected error: ${e.toString()}");
    }
  }
}
