import 'package:flutter/foundation.dart';
import 'package:frontend/DataLayer/Response/api_responces.dart';
import 'package:frontend/Repository/order_repo.dart';

class OrderProvider extends ChangeNotifier {
  final OrderRepo _orderRepo = OrderRepo();

  ApiResponces orderResponse = ApiResponces();

  Future<void> submitOrders() async {
    orderResponse = ApiResponces.loading();
    notifyListeners();
    orderResponse = await _orderRepo.submitOrders();
    notifyListeners();
  }
}
