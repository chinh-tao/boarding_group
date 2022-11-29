// To parse this JSON data, do
//
//     final billModel = billModelFromJson(jsonString);

import 'dart:convert';
import 'dart:ffi';

BillModel billModelFromJson(String str) => BillModel.fromJson(json.decode(str));

String billModelToJson(BillModel data) => json.encode(data.toJson());

class BillModel {
  BillModel({
    this.electricNumber,
    this.dateCreate,
    this.idBranch,
    this.bill,
    this.roomNumber,
    this.payment,
    this.deadline,
    this.nameBill,
  });

  int? electricNumber;
  String? dateCreate;
  String? idBranch;
  Bill? bill;
  String? roomNumber;
  List<Payment>? payment;
  String? deadline;
  String? nameBill;

  factory BillModel.fromJson(Map<String, dynamic> json) => BillModel(
        electricNumber: json["electricNumber"] == null
            ? null
            : json["electricNumber"],
        dateCreate: json["dateCreate"] ?? null,
        idBranch: json["idBranch"] ?? null,
        bill: json["bill"] == null ? null : Bill.fromJson(json["bill"]),
        roomNumber: json["roomNumber"] ?? null,
        payment: json["payment"] == null
            ? null
            : List<Payment>.from(
                json["payment"].map((x) => Payment.fromJson(x))),
        deadline: json["deadline"] ?? null,
        nameBill: json["nameBill"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "electricNumber": electricNumber == null ? null : electricNumber,
        "dateCreate": dateCreate ?? null,
        "idBranch": idBranch ?? null,
        "bill": bill == null ? null : bill!.toJson(),
        "roomNumber": roomNumber ?? null,
        "payment": payment == null
            ? null
            : List<dynamic>.from(payment!.map((x) => x.toJson())),
        "deadline": deadline ?? null,
        "nameBill": nameBill ?? null,
      };
}

class Bill {
  Bill({
    this.electric,
    this.general,
    this.network,
    this.room,
    this.water,
  });

  double? electric;
  double? general;
  double? network;
  double? room;
  double? water;

  factory Bill.fromJson(Map<String, dynamic> json) => Bill(
        electric:
            json["electric"] == null ? null : json["electric"]!.toDouble(),
        general: json["general"] == null ? null : json["general"]!.toDouble(),
        network: json["network"] == null ? null : json["network"]!.toDouble(),
        room: json["room"] == null ? null : json["room"]!.toDouble(),
        water: json["water"] == null ? null : json["water"]!.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "electric": electric ?? null,
        "general": general ?? null,
        "network": network ?? null,
        "room": room ?? null,
        "water": water ?? null,
      };
}

class Payment {
  Payment({
    this.name,
    this.category,
    this.date,
    this.status,
  });

  String? name;
  String? category;
  String? date;
  int? status;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        name: json["name"] ?? null,
        category: json["category"] ?? null,
        date: json["date"] ?? null,
        status: json["status"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "name": name ?? null,
        "category": category ?? null,
        "date": date ?? null,
        "status": status ?? null,
      };
}
