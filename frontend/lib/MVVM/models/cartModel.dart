class CartModel {
  String productId;
  String productName;
  String productImg;
  int quantity;
  int price;
  List<Map<String, dynamic>> selectedVarients;

  CartModel({
    required this.productId,
    required this.productName,
    required this.productImg,
    required this.quantity,
    required this.price,
    required this.selectedVarients,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      productId: json['productId'],
      productName: json['productName'],
      productImg: json['productImg'],
      quantity: json['quantity'],
      price: json['price'],
      selectedVarients: List<Map<String, dynamic>>.from(
        json['selectedVarients'] ?? [],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'productImg': productImg,
      'quantity': quantity,
      'price': price,
      'selectedVarients': selectedVarients,
    };
  }
}