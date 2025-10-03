class GetAllProducts {
  int? status;
  List<Products>? products;
  GetAllProducts({this.status, this.products});
  GetAllProducts.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? sId;
  String? userId;
  String? categoryId; // Change to String
  String? subcategoryId; // Change to String
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

  Products({
    this.sId,
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
    this.variantGroups,
  });

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    categoryId = json['categoryId']; // Treat as string
    subcategoryId = json['subcategoryId']; // Treat as string
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
        variantGroups!.add(VariantGroups.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['categoryId'] = categoryId; // Serialize as string
    data['subcategoryId'] = subcategoryId; // Serialize as string
    data['name'] = name;
    data['shortDescription'] = shortDescription;
    data['description'] = description;
    data['price'] = price;
    data['image'] = image;
    data['imageId'] = imageId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    if (variantGroups != null) {
      data['variantGroups'] = variantGroups!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class CategoryId {
//   String? sId;
//   String? userId;
//   String? name;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;
//   String? image;
//   String? imageId;
//   CategoryId({
//     this.sId,
//     this.userId,
//     this.name,
//     this.createdAt,
//     this.updatedAt,
//     this.iV,
//     this.image,
//     this.imageId,
//   });
//   CategoryId.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     userId = json['userId'];
//     name = json['name'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//     image = json['image'];
//     imageId = json['imageId'];
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['userId'] = userId;
//     data['name'] = name;
//     data['createdAt'] = createdAt;
//     data['updatedAt'] = updatedAt;
//     data['__v'] = iV;
//     data['image'] = image;
//     data['imageId'] = imageId;
//     return data;
//   }
// }

// class SubcategoryId {
//   String? sId;
//   String? userId;
//   String? name;
//   String? categoryId;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;
//   SubcategoryId({
//     this.sId,
//     this.userId,
//     this.name,
//     this.categoryId,
//     this.createdAt,
//     this.updatedAt,
//     this.iV,
//   });
//   SubcategoryId.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     userId = json['userId'];
//     name = json['name'];
//     categoryId = json['categoryId'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['userId'] = userId;
//     data['name'] = name;
//     data['categoryId'] = categoryId;
//     data['createdAt'] = createdAt;
//     data['updatedAt'] = updatedAt;
//     data['__v'] = iV;
//     return data;
//   }
// }

class VariantGroups {
  String? name;
  bool? isRequired;
  int? maxSelectable;
  List<Options>? options;
  String? sId;
  VariantGroups({
    this.name,
    this.isRequired,
    this.maxSelectable,
    this.options,
    this.sId,
  });
  VariantGroups.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isRequired = json['isRequired'];
    maxSelectable = json['maxSelectable'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
    sId = json['_id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['isRequired'] = isRequired;
    data['maxSelectable'] = maxSelectable;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    data['_id'] = sId;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    data['_id'] = sId;
    return data;
  }
}





