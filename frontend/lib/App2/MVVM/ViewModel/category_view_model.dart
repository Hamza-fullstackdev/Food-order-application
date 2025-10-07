import 'package:flutter/material.dart';
import 'package:frontend/App2/Data/Responses/api_response.dart';
import 'package:frontend/App2/Data/Responses/status.dart';
import 'package:frontend/App2/MVVM/Model/categories.dart';
import 'package:frontend/App2/Repository/category_repo.dart';

class CategoryViewModel extends ChangeNotifier{


  var _selectedIndex = 0;
  String _categoryId = "68c92b88cf8c8608857f0baa";


  String get categoryId => _categoryId;
  final _categoryRepo = CategoryRepo();
  final List<Categories> _categoryList = [];

  
  int get selectedIndex => _selectedIndex;

  List<Categories> get categoryList => _categoryList;


  ApiResponse _categoryApiResponse = ApiResponse.notStarted();
  ApiResponse get categoryApiResponse => _categoryApiResponse;

  void setIndex(int i, String name) {
    _selectedIndex = i;
    _categoryId = name;
    notifyListeners();
  }

    Future<void> categoriesData() async {
    _categoryApiResponse = ApiResponse.loading();
    _categoryList.clear();
    _categoryApiResponse = await _categoryRepo.getCategory();

    if (_categoryApiResponse.status == Status.Success) {
      _categoryList.addAll(_categoryApiResponse.data);
    }
    notifyListeners();
  }

}