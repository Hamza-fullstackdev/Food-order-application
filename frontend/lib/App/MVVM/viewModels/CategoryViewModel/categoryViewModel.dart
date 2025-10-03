import 'package:flutter/foundation.dart';
import 'package:frontend/App/Core/Responce/api_responce.dart';
import 'package:frontend/App/DataLAYER/repository/categoryRepo.dart/categoryRepo.dart';
import 'package:frontend/App/MVVM/models/categoryModle.dart';

class CategoryViewModel extends ChangeNotifier {
  final _categoryRepo = CategoryRepoo();
  final List<Categories> _categories = [];
   int _index = 0;

  List<Categories> get categories => _categories;

  int get index => _index;
  void changeIndex(int index) {
    _index = index;
    notifyListeners();
  }


  ApiResponce<GetAllCategories> _categoryResponce = ApiResponce.loading();
  ApiResponce<GetAllCategories> get categoryResponce => _categoryResponce;

  Future<void> getCategory() async {
    _categoryResponce = ApiResponce.loading();
    notifyListeners();

    try {
      final categoryData = await _categoryRepo.getAllCategories();

      _categoryResponce = categoryData;
      _categories.addAll(categoryData.data!.categories ?? []);
    } catch (e) {
      _categoryResponce = ApiResponce.error(e.toString());
    }

    notifyListeners();
  }

  void getIndex(int index) {
    _index =  index;
    notifyListeners();
  }
}
