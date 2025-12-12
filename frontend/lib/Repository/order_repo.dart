import 'package:frontend/DataLayer/Network/Interfaces/order_interface.dart';
import 'package:frontend/DataLayer/Network/Services/order_service.dart';
import 'package:frontend/DataLayer/Response/api_responces.dart';
import 'package:frontend/DataLayer/api_exceptions.dart';
import 'package:frontend/Resources/app_url.dart';

class OrderRepo {
  final OrderInterface _orders = OrderService();

  Future<ApiResponces<bool>> submitOrders() async {
    try {
      final url = ApiUrl.submitOrders;
      final data = await _orders.submitOrders(url);
      if (data != null && data['order'] != null) {
        return ApiResponces.success(data['order']);
      }
      return ApiResponces.error(data['message'] ?? 'Cart is empty.');
    } catch (e) {
      if (e is ApiException) {
        return ApiResponces.error(e.message);
      }
      return ApiResponces.error("Unexpected error: ${e.toString()}");
    }
  }
}
