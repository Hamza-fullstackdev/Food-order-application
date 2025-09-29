class ProductDetails {
  int? status;
  List<Products>? products;

  ProductDetails({this.status, this.products});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? sId;
  String? userId;
  String? categoryId;
  String? subcategoryId;
  String? name;
  String? shortDescription;
  String? description;
  int? price;
  String? image;
  String? imageId;
  String? createdAt;
  String? updatedAt;
  int? iV;
  List<VariantGroups>? variantGroups;

  Products(
      {this.sId,
      this.userId,
      this.categoryId,
      this.subcategoryId,
      this.name,
      this.shortDescription,
      this.description,
      this.price,
      this.image,
      this.imageId,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.variantGroups});

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    categoryId = json['categoryId'];
    subcategoryId = json['subcategoryId'];
    name = json['name'];
    shortDescription = json['shortDescription'];
    description = json['description'];
    price = json['price'];
    image = json['image'];
    imageId = json['imageId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    if (json['variantGroups'] != null) {
      variantGroups = <VariantGroups>[];
      json['variantGroups'].forEach((v) {
        variantGroups!.add(new VariantGroups.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['categoryId'] = this.categoryId;
    data['subcategoryId'] = this.subcategoryId;
    data['name'] = this.name;
    data['shortDescription'] = this.shortDescription;
    data['description'] = this.description;
    data['price'] = this.price;
    data['image'] = this.image;
    data['imageId'] = this.imageId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.variantGroups != null) {
      data['variantGroups'] =
          this.variantGroups!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VariantGroups {
  String? name;
  bool? isRequired;
  int? maxSelectable;
  List<Options>? options;
  String? sId;

  VariantGroups(
      {this.name, this.isRequired, this.maxSelectable, this.options, this.sId});

  VariantGroups.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isRequired = json['isRequired'];
    maxSelectable = json['maxSelectable'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['isRequired'] = this.isRequired;
    data['maxSelectable'] = this.maxSelectable;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    return data;
  }
}

class Options {
  String? name;
  int? price;
  String? sId;

  Options({this.name, this.price, this.sId});

  Options.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['_id'] = this.sId;
    return data;
  }
}
