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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['shortDescription'] = this.shortDescription;
    data['description'] = this.description;
    data['price'] = this.price;
    data['image'] = this.image;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['categoryId'] = this.categoryId;
    data['subcategoryId'] = this.subcategoryId;
    return data;
  }
}
