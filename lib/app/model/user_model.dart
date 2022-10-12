// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel(
      {this.id,
      this.email,
      this.pass,
      this.userName,
      this.device,
      this.images});

  String? id;
  String? email;
  String? pass;
  String? userName;
  String? device;
  String? images;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json["id"] == null ? null : json["id"],
      email: json["email"] == null ? null : json["email"],
      pass: json["pass"] == null ? null : json["pass"],
      userName: json["userName"] == null ? null : json["userName"],
      device: json["deviceMobi"] == null ? null : json["deviceMobi"],
      images: json["images"] == null || json["images"] == ''
          ? null
          : json["images"]);

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "email": email == null ? null : email,
        "pass": pass == null ? null : pass,
        "userName": userName == null ? null : userName,
        "deviceMobi": device == null ? null : device,
        "images": images == null ? null : images
      };
}
