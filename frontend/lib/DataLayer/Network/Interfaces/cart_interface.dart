abstract class CartInterface {
  Future<dynamic> addItemToCart(Map<String,dynamic> body,String url);
  Future<dynamic> removeItemFromCart(String url);
  Future<dynamic> updateCart(Map<String,dynamic> body,String url);
  Future<dynamic> getAllCarts(String url);

  Future<dynamic> getSecretKey(String url,Map<String,double> body);
}