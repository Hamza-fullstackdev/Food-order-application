import 'package:frontend/DataLayer/Network/Interfaces/order_interface.dart';
import 'package:frontend/DataLayer/Network/Services/order_service.dart';
import 'package:frontend/DataLayer/Response/api_responces.dart';
import 'package:frontend/DataLayer/api_exceptions.dart';
import 'package:frontend/MVVM/models/routes_direction.dart';
import 'package:frontend/Resources/app_url.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderRepo {
  final OrderInterface _orders = OrderService();

  Future<ApiResponces<bool>> submitOrders() async {
    try {
      final url = ApiUrl.submitOrders;
      final data = await _orders.submitOrders(url);
      if (data != null && data['order'] != null) {
        return ApiResponces.success(true);
      }
      return ApiResponces.failed(data['message'] ?? 'Cart is empty.');
    } catch (e) {
      if (e is ApiException) {
        return ApiResponces.failed(e.message);
      }
      return ApiResponces.failed("Unexpected error: ${e.toString()}");
    }
  }

  Future<ApiResponces<List<LatLng>>> getRoutes(
    LatLng start,
    LatLng end,
    String apiKey,
  ) async {
    try {
      final url =
          'https://api.openrouteservice.org/v2/directions/driving-car?start=${start.longitude},${start.latitude}&end=${end.longitude},${end.latitude}';

      final data = await _orders.getRoutes(url, apiKey);

      if (data == null) {
        return ApiResponces.failed('No response from routing service');
      }

      final routeResponse = RouteResponse.fromJson(data);

      if (routeResponse.features.isEmpty) {
        return ApiResponces.failed('No route found');
      }
      final polylinePoints = routeResponse.features.first.geometry.points;

      return ApiResponces.success(polylinePoints);
    } catch (e) {
      if (e is ApiException) {
        return ApiResponces.failed(e.message);
      }
      return ApiResponces.failed("Unexpected error: ${e.toString()}");
    }
  }
}
