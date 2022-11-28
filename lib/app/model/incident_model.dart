// To parse this JSON data, do
//
//     final incidentModel = incidentModelFromJson(jsonString);

import 'dart:convert';

IncidentModel incidentModelFromJson(String str) =>
    IncidentModel.fromJson(json.decode(str));

String incidentModelToJson(IncidentModel data) => json.encode(data.toJson());

class IncidentModel {
  IncidentModel({
    this.title,
    this.date,
    this.userName,
    this.level,
    this.roomNumber,
    this.status,
    this.idBranch,
    this.content,
  });

  String? title;
  String? date;
  String? userName;
  String? level;
  String? roomNumber;
  int? status;
  String? idBranch;
  String? content;

  factory IncidentModel.fromJson(Map<String, dynamic> json) => IncidentModel(
        title: json["title"] ?? null,
        date: json["date"] ?? null,
        userName: json["userName"] ?? null,
        level: json["level"] ?? null,
        roomNumber: json["roomNumber"] ?? null,
        idBranch: json["idBranch"] ?? null,
        status: json["status"]! == null ? null : json["status"],
        content: json["content"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "title": title ?? null,
        "date": date == null ? null : date,
        "userName": userName ?? null,
        "level": level ?? null,
        "roomNumber": roomNumber ?? null,
        "status": status == null ? null : status,
        "idBranch": idBranch ?? null,
        "content": content ?? null,
      };
}
