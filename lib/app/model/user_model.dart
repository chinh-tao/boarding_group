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
      this.userName,
      this.device,
      this.images,
      this.roomNumber,
      this.phone});

  String? id;
  String? email;
  String? userName;
  String? device;
  String? images;
  String? roomNumber;
  String? phone;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json["id"] == null ? null : json["id"],
      email: json["email"] == null ? null : json["email"],
      userName: json["userName"] == null ? null : json["userName"],
      phone: json["phone"] == null ? null : json["phone"],
      device: json["deviceMobi"] == null ? null : json["deviceMobi"],
      images: json["images"] == null || json["images"] == ''
          ? null
          : json["images"],
      roomNumber: json["roomNumber"] == null ? null : json["roomNumber"]);

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "email": email == null ? null : email,
        "userName": userName == null ? null : userName,
        "phone": phone == null ? null : phone,
        "deviceMobi": device == null ? null : device,
        "images": images == null ? null : images,
        "roomNumber": roomNumber == null ? null : roomNumber
      };

  String get getID {
    if (id == null) {
      return '';
    }
    return id!;
  }

  String get getEmail {
    if (email == null) {
      return '';
    }
    return email!;
  }

  String get getUserName {
    if (userName == null) {
      return '';
    }
    return userName!;
  }

  String get getImages {
    if (images == null) {
      return '';
    }
    return images!;
  }

  String get getRoomNumber {
    if (roomNumber == null) {
      return '';
    }
    return roomNumber!;
  }

  String get getPhone {
    if (phone == null) {
      return '';
    }
    return phone!;
  }
}
