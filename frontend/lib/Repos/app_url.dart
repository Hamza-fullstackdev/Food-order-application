class AppUrl {
  static final base_url = "http://192.168.1.107:3000/api/v1/";

  static final login_url = "${base_url}auth/login";
  static final signup_url = "${base_url}auth/register";
  static final refresh_url = "${base_url}auth/refresh-token";
  static final user_delete_url = "${base_url}auth/delete-user";
  static final logout_url = "${base_url}auth/logout";

  static final addProduct_url = "${base_url}product/add-product";
  static final get_all_product_url = "${base_url}product/get-all-products";
  static final prodcut_by_Id_url = "${base_url}product/get-product/";
  static final product_by_user_id_url =
      "${base_url}product/get-products-by-user";

  static final get_by_categry_id_url = "${base_url}product/get-by-category/";
  static final delete_product_url = "${base_url}product/delete-product/";
  static final get_all_categories_url =
      "${base_url}category/get-all-categories";
}
