class Products {
  String? sId;
  String? userId;
  String? name;
  String? shortDescription;
  String? description;
  double? price;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? categoryId;
  String? subcategoryId;

  Products(
      {
      this.sId,
      this.userId,
      this.name,
      this.shortDescription,
      this.description,
      this.price,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.categoryId,
      this.subcategoryId
      });

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    name = json['name'];
    shortDescription = json['shortDescription'];
    description = json['description'];
    price = json['price'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    categoryId = json['categoryId'];
    subcategoryId = json['subcategoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['name'] = name;
    data['shortDescription'] = shortDescription;
    data['description'] = description;
    data['price'] = price;
    data['image'] = image;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['categoryId'] = categoryId;
    data['subcategoryId'] = subcategoryId;
    return data;
  }
}
