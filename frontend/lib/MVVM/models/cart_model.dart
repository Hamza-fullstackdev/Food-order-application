// ignore_for_file: prefer_collection_literals, unnecessary_this, unnecessary_new

class CartModel {
  String? sId;
  int? quantity;
  int? itemTotal;
  Product? product;

  CartModel({this.sId, this.quantity, this.itemTotal, this.product});

  CartModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    quantity = json['quantity'];
    itemTotal = json['itemTotal'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['quantity'] = this.quantity;
    data['itemTotal'] = this.itemTotal;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  String? sId;
  String? name;
  String? image;
  List<VariantGroups>? variantGroups;

  Product({this.sId, this.name, this.image, this.variantGroups});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
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
    data['name'] = this.name;
    data['image'] = this.image;
    if (this.variantGroups != null) {
      data['variantGroups'] =
          this.variantGroups!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VariantGroups {
  String? sId;
  String? name;
  List<Options>? options;

  VariantGroups({this.sId, this.name, this.options});

  VariantGroups.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
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
