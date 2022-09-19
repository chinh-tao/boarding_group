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
      this.deviceMobi,
      this.images});

  String? id;
  String? email;
  String? pass;
  String? userName;
  String? device;
  String? deviceMobi;
  String? images;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json["id"] == null ? null : json["id"],
      email: json["email"] == null ? null : json["email"],
      pass: json["pass"] == null ? null : json["pass"],
      userName: json["user_name"] == null ? null : json["user_name"],
      device: json["device"] == null ? null : json["device"],
      deviceMobi: json["device_mobi"] == null ? null : json["device_mobi"],
      images: json["images"] == null || json["images"] == ''
          ? null
          : json["images"]);

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "email": email == null ? null : email,
        "pass": pass == null ? null : pass,
        "user_name": userName == null ? null : userName,
        "device": device == null ? null : device,
        "device_mobi": deviceMobi == null ? null : deviceMobi,
        "images": images == null ? null : images
      };
}
