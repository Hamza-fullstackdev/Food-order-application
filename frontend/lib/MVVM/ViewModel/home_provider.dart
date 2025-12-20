// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:frontend/DataLayer/Response/api_responces.dart';
import 'package:frontend/Repository/category_repo.dart';
import 'package:frontend/Repository/product_repo.dart';

class HomeProvider extends ChangeNotifier {
  final CategoryRepo _categoryRepo = CategoryRepo();
  final ProductRepo _productRepo = ProductRepo();

  ApiResponces _categoryResponse = ApiResponces();
  ApiResponces _productResponse = ApiResponces();

  String _categoryId = '68c92b52cf8c8608857f0b9e';
  int _categoryIndex = 0;

  String get categoryId => _categoryId;
  int get categoryIndex => _categoryIndex;

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

  void updateCategoryId(String Id,int index){
    _categoryId = Id;
    _categoryIndex = index;
    notifyListeners();
  }


}
