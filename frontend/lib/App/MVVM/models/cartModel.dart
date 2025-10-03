class CartModel {
  final String pId;
  final String image;
  final String productName;
  final String productShortDescription;
  final String productPrice;
  final Map<String, String?> selectedSize; // {name, id} for size
  final List<Map<String, String?>> selectedOptionalVariants; // [{name, id}, ...] for toppings
  int quantity; // Added for quantity management

  CartModel({
    required this.pId,
    required this.image,
    required this.productName,
    required this.productShortDescription,
    required this.productPrice,
    required this.selectedSize,
    required this.selectedOptionalVariants,
    this.quantity = 1, // Default quantity
  });

  // Convert to JSON for debugging or API
  Map<String, dynamic> toJson() {
    return {
      'pId': pId,
      'image': image,
      'productName': productName,
      'productShortDescription': productShortDescription,
      'productPrice': productPrice,
      'selectedSize': selectedSize,
      'selectedOptionalVariants': selectedOptionalVariants,
      'quantity': quantity,
    };
  }
}