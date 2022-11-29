import 'package:flutter/material.dart';

class ServiceController extends ChangeNotifier {
  final listService = [
    ServiceModel(icon: Icons.electric_meter, title: "Điện\n3.500đ/kwh"),
    ServiceModel(icon: Icons.water_drop_rounded, title: "Nước\n25.000đ/người"),
    ServiceModel(icon: Icons.wifi, title: "Wifi\n100.000đ/phòng"),
    ServiceModel(
        icon: Icons.miscellaneous_services_outlined,
        title: "Dịch vụ chung\n45.000đ/phòng"),
  ];
}

class ServiceModel {
  IconData? icon;
  String? title;

  ServiceModel({this.icon, this.title});
}
