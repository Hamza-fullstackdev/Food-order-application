import 'package:flutter/foundation.dart';
import 'package:frontend/DataLayer/Response/api_responces.dart';
import 'package:frontend/Repository/order_repo.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderProvider extends ChangeNotifier {
  final OrderRepo _orderRepo = OrderRepo();

  ApiResponces orderResponse = ApiResponces();
  ApiResponces<List<LatLng>> routesResponse = ApiResponces();

  Future<void> submitOrders() async {
    orderResponse = ApiResponces.loading();
    notifyListeners();
    orderResponse = await _orderRepo.submitOrders();
    notifyListeners();
  }

  Future<void> getRoutes(LatLng start,LatLng end,String apiKey) async {
    routesResponse = ApiResponces.loading();
    notifyListeners();
    routesResponse = await _orderRepo.getRoutes(start,end,apiKey);
    notifyListeners();
  }
}
