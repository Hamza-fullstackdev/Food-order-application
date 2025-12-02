class ApiUrl {
  static final String baseUrl = 'http://192.168.0.109:5000/api/v1/';
  static final String registerUrl = '${baseUrl}auth/register';
  static final String loginUrl = '${baseUrl}auth/login';

  static final String refreshTokenUrl = '${baseUrl}auth/refresh-token';


  static final String allCategoriesUrl = '${baseUrl}category/get-all-categories';

  static final String getProductsByCategoryIdUrl = '${baseUrl}product/get-by-category/';


}
