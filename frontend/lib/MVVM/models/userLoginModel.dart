// ignore_for_file: file_names

class UserLoginModel {
  int? status;
  String? message;
  User? user;

  UserLoginModel({this.status, this.message, this.user});

  UserLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? sId;
  String? name;
  String? email;
  String? profileImage;
  bool? isAdmin;
  String? accessToken;
  String? refreshToken;

  User(
      {this.sId,
      this.name,
      this.email,
      this.profileImage,
      this.isAdmin,
      this.accessToken,
      this.refreshToken});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    profileImage = json['profileImage'];
    isAdmin = json['isAdmin'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['profileImage'] = profileImage;
    data['isAdmin'] = isAdmin;
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    return data;
  }
}