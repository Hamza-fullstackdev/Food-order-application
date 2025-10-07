import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/App2/Data/Responses/api_response.dart';
import 'package:frontend/App2/Data/Responses/status.dart';
import 'package:frontend/App2/Repository/products_repo.dart';
import 'package:frontend/App2/MVVM/Model/products.dart';

class ProductProvider extends ChangeNotifier {
  final _productsRepo = ProductsRepo();
  
  
  ApiResponse _productApiResponse = ApiResponse.notStarted();
  final List<Products> _productsList = [];
  String _productId = "";

  String get productId => _productId;

  List<Products> get productList => _productsList;

  ApiResponse get productApiResponse => _productApiResponse;

  void setProductId(String id) {
    _productId = id;
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
}
