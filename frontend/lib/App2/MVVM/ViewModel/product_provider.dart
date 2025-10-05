import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/App2/Data/Responses/api_response.dart';
import 'package:frontend/App2/Data/Responses/status.dart';
import 'package:frontend/App2/Repository/category_repo.dart';
import 'package:frontend/App2/Repository/products_repo.dart';
import 'package:frontend/App2/MVVM/Model/categories.dart';
import 'package:frontend/App2/MVVM/Model/products.dart';

class ProductProvider extends ChangeNotifier {
  final _sleectedItemIndex = false;
  String? _selectedOption;
  
  Map<String, String?> selectedVariants = {};
  Map<String, Set<String>> selectedCheckboxes = {};
  // final _selectedVariationItemIndex;

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

  ApiResponse get productApiResponse => _productApiResponse;
  ApiResponse get categoryApiResponse => _categoryApiResponse;
  ApiResponse get singleProductApiResponse => _singleProductApiResponse;


  void selectSingleOption(String groupName, String optionId) {
    selectedVariants[groupName] = optionId;
    notifyListeners();
  }

  String? getSelectedOption(String groupName) {
    return selectedVariants[groupName];
  }

  void toggleCheckbox(String groupName, String optionId, bool checked) {
    selectedCheckboxes[groupName] ??= {};
    if (checked) {
      selectedCheckboxes[groupName]!.add(optionId);
    } else {
      selectedCheckboxes[groupName]!.remove(optionId);
    }
    notifyListeners();
  }

  bool isChecked(String groupName, String optionId) {
    return selectedCheckboxes[groupName]?.contains(optionId) ?? false;
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

  Future<void> categoriesData() async {
    _categoryApiResponse = ApiResponse.loading();
    _categoryList.clear();
    _categoryApiResponse = await _categoryRepo.getCategory();

    if (_categoryApiResponse.status == Status.Success) {
      _categoryList.addAll(_categoryApiResponse.data);
    }
    notifyListeners();
  }

  Future<void> getProducts(String categoryId) async {
    _productApiResponse = ApiResponse.loading();
    _productsList.clear();

    _productApiResponse = await _productsRepo.getProducts(categoryId);

    if (_productApiResponse.status == Status.Success) {
      _productsList.addAll(_productApiResponse.data);
    }
    notifyListeners();
  }

  Future<void> getSingleProduct({required String id}) async {
    _singleProductApiResponse = ApiResponse.loading();

    _singleProductApiResponse = await _productsRepo.getSingleProduct(id);
    if (_singleProductApiResponse.status == Status.Success) {
      _products = _singleProductApiResponse.data;
    }
    notifyListeners();
  }
}
