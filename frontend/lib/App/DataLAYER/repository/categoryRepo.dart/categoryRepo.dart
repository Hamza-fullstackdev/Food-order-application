
import 'package:frontend/App/Core/Responce/api_responce.dart';
import 'package:frontend/App/Core/Exceptions/exceptions.dart';
import 'package:frontend/App/DataLAYER/Service/categoryService/category_service.dart';
import 'package:frontend/App/MVVM/models/categoryModle.dart';
import 'package:frontend/App2/Resources/app_url.dart';

class CategoryRepoo {
  CategoryRepoo._private();
  static CategoryRepoo instance = CategoryRepoo._private();
  factory CategoryRepoo() {
    return instance;
  }

  final _categoryService = CategoryService();

  Future<ApiResponce<GetAllCategories>> getAllCategories() async {

    try {
       final categories = await _categoryService.getAllCategories(
      AppUrl.get_all_categories_url,
    );


    return ApiResponce.success(GetAllCategories.fromJson(categories));
  
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
