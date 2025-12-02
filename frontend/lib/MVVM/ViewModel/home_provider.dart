import 'package:flutter/material.dart';
import 'package:frontend/DataLayer/Response/api_responces.dart';
import 'package:frontend/Repository/category_repo.dart';
import 'package:frontend/Repository/product_repo.dart';

class HomeProvider extends ChangeNotifier {
  final CategoryRepo _categoryRepo = CategoryRepo();
  final ProductRepo _productRepo = ProductRepo();

  ApiResponces _categoryResponse = ApiResponces();
  ApiResponces _productResponse = ApiResponces();

  ApiResponces get categoryResponse => _categoryResponse;
  ApiResponces get productResponse => _productResponse;

  Future<void> fetchCategories() async {
    _categoryResponse = ApiResponces.loading();
    notifyListeners();
    _categoryResponse = await _categoryRepo.getCategories();
    notifyListeners();
  }

  Future<void> fetchProductById(String selectedId) async {
    _productResponse = ApiResponces.loading();
    notifyListeners();
    _productResponse = await _productRepo.getProductsByCategoryId(selectedId);
    notifyListeners();
  }
}
