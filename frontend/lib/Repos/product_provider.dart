import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/Repos/app_url.dart';
import 'package:frontend/helper_classes/token_refresh.dart';
import 'package:frontend/models/categories.dart';
import 'package:frontend/models/products.dart';

class ProductProvider extends ChangeNotifier {
  final List<Categories> _categoryList = [];
  final List<Products> _productsList = [];
  Products _products = Products();

  var _selectedIndex = 0;
  String _categoryId = "68c92b88cf8c8608857f0baa";
  String _productId = "";

  String get categoryId => _categoryId;
  int get selectedIndex => _selectedIndex;
  String get productId => _productId;

  Products get products => _products;
  List<Categories> get categoryList => _categoryList;
  List<Products> get productList => _productsList;

  void setIndex(int i, String name) {
    _selectedIndex = i;
    _categoryId = name;
    notifyListeners();
  }

  void setProductId(String id) {
    _productId = id;
    notifyListeners();
  }

  Future<dynamic> categoriesData() async {
    final data = await TokenRefresh.checkToken(AppUrl.get_all_categories_url);
    if (data != null && data["categories"] != null) {
      _categoryList.clear();
      for (Map<String, dynamic> items in data["categories"]) {
        _categoryList.add(Categories.fromJson(items));
        print(Categories.fromJson(items).sId);
      }

      //  notifyListeners();
      return categoryList;
    } else {
      //  notifyListeners();

      print("No data sorry");
      return [];
    }
  }

  Future<List<Products>> getProducts(String categoryId) async {
    final data = await TokenRefresh.checkToken(
      "${AppUrl.get_product_list_by_category_id}$categoryId",
    );

    if (data != null && data['products'] != null) {
      _productsList.clear();
      for (var currentProduct in data['products']) {
        _productsList.add(Products.fromJson(currentProduct));
      }
      print(_productsList[2].sId);
      return productList;
    } else {
      print("No product Found!");
      return [];
    }
  }

  Future<Products> getSingleProduct(String? id) async {
    print("Id is : $id");
    final data;
    if (id != null) {
      
      print("Id is not null : $id");
      data = await TokenRefresh.checkToken("${AppUrl.get_single_product}$id");
      

      if (data != null && data['product'] != null) {
        print("data of product is : $data");
        _products = Products.fromJson(data['product']);
        print(" \n \n data of _product is : $_products");
        return products;
      } else {
        return Products();
      }
    } else {
      return Products();
    }
  }
}
