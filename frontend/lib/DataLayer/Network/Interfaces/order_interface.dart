abstract class OrderInterface {
  Future<dynamic> submitOrders(String url);
  Future<dynamic> getRoutes(String url,String apiKey);
}
