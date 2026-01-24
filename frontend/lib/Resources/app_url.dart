class ApiUrl {
  static final String baseUrl = 'http://192.168.0.115:5000/api/v1/';
  static final String registerUrl = '${baseUrl}auth/register';
  static final String loginUrl = '${baseUrl}auth/login';

  static final String refreshTokenUrl = '${baseUrl}auth/refresh-token';

  static final String allCategoriesUrl =
      '${baseUrl}category/get-all-categories';

  static final String getProductsByCategoryIdUrl =
      '${baseUrl}product/get-by-category/';

  static final String addItemToCartUrl = '${baseUrl}cart/add-to-cart';
  static final String removeItemFromCart = '${baseUrl}cart/remove-from-cart/';
  static final String updateCartUrl = '${baseUrl}cart/update-cart/';
  static final String getAllCartsUrl = '${baseUrl}cart/get-cart';

  static final String submitOrders = '${baseUrl}order/create-order';

  static final String paymentUrl =
      'http://192.168.8.15:8080/api/payment/create-payment-intent';
}
