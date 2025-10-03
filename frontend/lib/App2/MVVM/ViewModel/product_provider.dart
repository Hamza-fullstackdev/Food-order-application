import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/App2/Data/Responses/api_response.dart';
import 'package:frontend/App2/Data/Responses/status.dart';
import 'package:frontend/App2/Repository/category_repo.dart';
import 'package:frontend/App2/Repository/products_repo.dart';
import 'package:frontend/App2/MVVM/Model/categories.dart';
import 'package:frontend/App2/MVVM/Model/products.dart';

class ProductProvider extends ChangeNotifier {
  final _categoryRepo = CategoryRepo();
  final _productsRepo = ProductsRepo();
  ApiResponse _productApiResponse = ApiResponse.notStarted();
  ApiResponse _categoryApiResponse = ApiResponse.notStarted();
  ApiResponse _singleProductApiResponse = ApiResponse.notStarted();

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

   Map<String, String> selectedOptions = {}; // for radio (single choice)
  Map<String, Set<String>> multiSelectedOptions = {}; // for checkboxes (multi-choice)

  void selectSingleOption(String groupId, String optionId) {
    selectedOptions[groupId] = optionId;
    notifyListeners();
  }

  void toggleMultiOption(String groupId, String optionId) {
    multiSelectedOptions.putIfAbsent(groupId, () => {});
    if (multiSelectedOptions[groupId]!.contains(optionId)) {
      multiSelectedOptions[groupId]!.remove(optionId);
    } else {
      multiSelectedOptions[groupId]!.add(optionId);
    }
    notifyListeners();
  }

  void setIndex(int i, String name) {
    _selectedIndex = i;
    _categoryId = name;
    notifyListeners();
  }

  void setProductId(String id) {
    _productId = id;
    notifyListeners();
  }

  Future<List<Categories>> categoriesData() async {
    _categoryList.clear();
    _categoryApiResponse = await _categoryRepo.getCategory();

    if (_categoryApiResponse.status == Status.Success) {
      _categoryList.addAll(_categoryApiResponse.data);
      return categoryList;
    } else {
      return [];
    }
  }

  Future<List<Products>> getProducts(String categoryId) async {
    _productApiResponse = ApiResponse.loading();
    _productsList.clear();

    _productApiResponse = await _productsRepo.getProducts(categoryId);

    if (_productApiResponse.status == Status.Success) {
      _productsList.addAll(_productApiResponse.data);
      return productList;
    }
    return [];
  }

  Future<Products> getSingleProduct(String? id) async {
    _singleProductApiResponse = ApiResponse.loading();
    if (id != null) {

      _singleProductApiResponse = await _productsRepo.getSingleProduct(id);
      if (_singleProductApiResponse.status == Status.Success) {
        _products = _singleProductApiResponse.data;
        
        return products;
      }
    }
    return Products();
  }
}
