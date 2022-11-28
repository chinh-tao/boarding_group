import 'package:boarding_group/app/common/api.dart';
import 'package:boarding_group/app/common/global.dart';
import 'package:boarding_group/app/model/incident_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../common/auth.dart';
import '../../../common/utils.dart';

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
