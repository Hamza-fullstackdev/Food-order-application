class getCategoryModel{
  int? status;
  List<Categories>? categories;

  getCategoryModel({this.status, this.categories});

  getCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class  Categories {
  String? sId;
  String? userId;
  String? name;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? image;
  String? imageId;

  Categories(
      {this.sId,
      this.userId,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.image,
      this.imageId});

  Categories.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    image = json['image'];
    imageId = json['imageId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['name'] = name;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['image'] = image;
    data['imageId'] = imageId;
    return data;
  }
}
