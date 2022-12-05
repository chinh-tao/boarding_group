// To parse this JSON data, do
//
//     final noticeModel = noticeModelFromJson(jsonString);

import 'dart:convert';

List<NoticeModel> noticeModelFromJson(String str) => List<NoticeModel>.from(
    json.decode(str).map((x) => NoticeModel.fromJson(x)));

String noticeModelToJson(List<NoticeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NoticeModel {
  NoticeModel({
    this.title,
    this.date,
    this.content,
    this.idBranch,
  });

  String? title;
  String? date;
  String? content;
  String? idBranch;

  factory NoticeModel.fromJson(Map<String, dynamic> json) => NoticeModel(
        title: json["title"] == null ? null : json["title"],
        date: json["date"] == null ? null : json["date"],
        content: json["content"] == null ? null : json["content"],
        idBranch: json["idBranch"] == null ? null : json["idBranch"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "date": date == null ? null : date,
        "content": content == null ? null : content,
        "idBranch": idBranch == null ? null : idBranch,
      };
}
