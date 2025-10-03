import 'package:flutter/foundation.dart';
import 'package:frontend/App/Core/Responce/api_responce.dart';
import 'package:frontend/App/DataLAYER/repository/productsRepo/productRepo.dart';
import 'package:frontend/App/MVVM/models/GetProduct_ByCategoryId.dart';

class ProductViewModel extends ChangeNotifier {
  final _productRepo = ProductRepoo();

  ApiResponce<GetAllProducts> _productResponce = ApiResponce.loading();
  ApiResponce<GetAllProducts> get productResponce => _productResponce;

  Future<void> getAllProducts({required String pId}) async {
    _productResponce = ApiResponce.loading();
    notifyListeners();

    try {
      final productData = await _productRepo.getAllProducts(id: pId);
      _productResponce = productData;
    } catch (e) {
      _productResponce = ApiResponce.error(e.toString());
    }

    notifyListeners();
  }
   void setError(String message) {
  _productResponce = ApiResponce.error(message);
  notifyListeners();
}




}