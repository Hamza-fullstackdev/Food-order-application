import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/App2/Resources/app_url.dart';
import 'package:frontend/App2/Repository/token_refresh.dart';
import 'package:frontend/App2/MVVM/ViewModel/categories.dart';
import 'package:frontend/App2/MVVM/Model/products.dart';

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
        // print(Categories.fromJson(items).name);
        // print(Categories.fromJson(items).sId);
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
    print("Passes Id is $categoryId\n");
    final data = await TokenRefresh.checkToken(
      "${AppUrl.get_product_list_by_category_id}$categoryId",
    );
    
    print("Data is $data");
    if (data != null && data['products'] != null) {
      print("After condition data is ${data['products']}");
      _productsList.clear();
      for (var currentProduct in data['products']) {
        print("current product is $currentProduct");
        try {
          final product = Products.fromJson(currentProduct);
          
        _productsList.add(product);
        print("After Adding product is $currentProduct");

        } catch (e) {
          print(e.toString());
        }


      }
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
