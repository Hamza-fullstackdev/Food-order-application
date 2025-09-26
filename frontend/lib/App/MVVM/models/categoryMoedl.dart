// class GetAllCategory {
//   int? status;
//   List<Categories>? categories;

//   GetAllCategory({this.status, this.categories});

//   GetAllCategory.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     if (json['categories'] != null) {
//       categories = <Categories>[];
//       json['categories'].forEach((v) {
//         categories!.add(Categories.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     if (categories != null) {
//       data['categories'] = categories!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Categories {
//   String? sId;
//   String? userId;
//   String? name;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;
//   String? image;
//   String? imageId;

//   Categories(
//       {this.sId,
//       this.userId,
//       this.name,
//       this.createdAt,
//       this.updatedAt,
//       this.iV,
//       this.image,
//       this.imageId});

//   Categories.fromJson(Map<String, dynamic> json) {
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

class GetAllCategories {
  int? status;
  List<Categories>? categories;

  GetAllCategories({this.status, this.categories});

  GetAllCategories.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? sId;
  String? userId;
  String? name;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? image;
  String? imageId;

  Categories({
    this.sId,
    this.userId,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.image,
    this.imageId,
  });

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['image'] = this.image;
    data['imageId'] = this.imageId;
    return data;
  }
}
