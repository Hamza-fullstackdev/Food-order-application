class AppUrl {
  // static final base_url =  "http://192.168.101.50:5000/api/v1/";
  static final base_url = "http://192.168.1.9:5000/api/v1/";

  static final login_url = "${base_url}auth/login";
  static final signup_url = "${base_url}auth/register";
  static final refresh_url = "${base_url}auth/refresh-token";

  static final get_single_product = "${base_url}product/get-product/";
  static final get_product_list_by_category_id =
      "${base_url}product/get-by-category/";
  static final get_all_categories_url =
      "${base_url}category/get-all-categories";
}

class AppStrings {
  static const String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGQyOTFhYjYwNjExNjMzNzg2NzlhOTYiLCJpYXQiOjE3NTk0MTc2MTYsImV4cCI6MTc1OTQxODUxNn0.mhkz8y8PdprILSBKz8YT_9qkPQmlWvj2auOp13Cc5m8';
}
