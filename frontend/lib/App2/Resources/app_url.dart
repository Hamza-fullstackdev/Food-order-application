class AppUrl {
  static final base_url = "http://192.168.1.107:5000/api/v1/";

  static final login_url = "${base_url}auth/login";
  static final signup_url = "${base_url}auth/register";
  static final refresh_url = "${base_url}auth/refresh-token";

  static final get_single_product = "${base_url}product/get-product/";
  static final get_product_list_by_category_id = "${base_url}product/get-by-category/";
  static final get_all_categories_url =
      "${base_url}category/get-all-categories";
}
