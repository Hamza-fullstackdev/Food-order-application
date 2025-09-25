
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/Repos/app_url.dart';
import 'package:frontend/helper_classes/token_refresh.dart';
import 'package:frontend/models/categories.dart';
import 'package:frontend/models/products.dart';

class ProductProvider extends ChangeNotifier {
  final List<Categories> _categoryList = [];
  final List<Products> _productsList = [];

  var _selectedIndex = 0;
  String _categoryId = "68c92b17cf8c8608857f0b96";

  String get categoryId => _categoryId;
  int get selectedIndex => _selectedIndex;

  List<Categories> get categoryList => _categoryList;
  List<Products> get productList => _productsList;

  void setIndex(int i,String name){
    _selectedIndex = i;
    _categoryId = name;
    notifyListeners();
  }
  Future<List<Categories>> categoriesData() async {
      
   final data  = await TokenRefresh.checkToken(AppUrl.get_all_categories_url);
    if(data != null && data["categories"] != null){
      _categoryList.clear();
    for(Map<String,dynamic> items in data["categories"]){
      _categoryList.add(Categories.fromJson(items));
      print(Categories.fromJson(items).sId);
    }
    

    //  notifyListeners();
     return categoryList;
    }else{
    //  notifyListeners();

      print("No data sorry");
      return [];
    }
        
    }
 
  Future<List<Products>> getProducts(String categoryId) async {
    final data = await TokenRefresh.checkToken("${AppUrl.get_by_categry_id_url}$categoryId");

      if (data != null && data['products'] != null) {
        _productsList.clear();
        for(var currentProduct in data['products']){
          _productsList.add(Products.fromJson(currentProduct));
          
        }
        print(_productsList[2].shortDescription);
        return productList;
      } else {
        print("No product Found!");
        return [];
      } 
    
  }
}