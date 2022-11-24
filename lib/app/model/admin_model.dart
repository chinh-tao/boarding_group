// To parse this JSON data, do
//
//     final adminModel = adminModelFromJson(jsonString);

import 'dart:convert';

AdminModel adminModelFromJson(String str) =>
    AdminModel.fromJson(json.decode(str));

String adminModelToJson(AdminModel data) => json.encode(data.toJson());

class AdminModel {
  AdminModel({
    this.name,
    this.phone,
    this.idBranch,
  });

  String? name;
  String? phone;
  String? idBranch;

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
        name: json["name"] == null ? null : json["name"],
        phone: json["phone"] == null ? null : json["phone"],
        idBranch: json["id_branch"] == null ? null : json["id_branch"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "phone": phone == null ? null : phone,
        "id_branch": idBranch == null ? null : idBranch,
      };

  String get getName {
    if (name == null) {
      return '';
    }
    return name!;
  }

  String get getPhone {
    if (phone == null) {
      return '';
    }
    return phone!;
  }
}
