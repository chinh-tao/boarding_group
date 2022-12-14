import 'dart:async';

import 'package:boarding_group/app/common/utils.dart';
import 'package:boarding_group/app/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../common/global.dart';

class HomeController extends ChangeNotifier {
  HomeController(this.ref);

  TextEditingController inputRoom = TextEditingController();
  TextEditingController inputName = TextEditingController();

  Timer? timer;
  final Ref ref;
  final _log = Logger();
  var isLoading = false;
  var listMember = <UserModel>[];

  void initData() async {
    await getListMember();
  }

  void handleSearchName(String value) {
    if (timer?.isActive ?? false) timer!.cancel();
    inputName.value = TextEditingValue(
        text: value, selection: TextSelection.collapsed(offset: value.length));
    timer = Timer(const Duration(seconds: 1), () async {
      await getListMember();
    });
  }

  void handleSearchRoom(String value) {
    if (timer?.isActive ?? false) timer!.cancel();
    inputRoom.value = TextEditingValue(
        text: value, selection: TextSelection.collapsed(offset: value.length));
    timer = Timer(const Duration(seconds: 1), () async {
      await getListMember();
    });
  }

  Future<void> getListMember({bool isRefresh = false}) async {
    final form = <String, dynamic>{};
    if (inputName.text.isNotEmpty) form['user_name'] = inputName.text.trim();
    if (inputRoom.text.isNotEmpty) form['room_number'] = inputRoom.text.trim();
    if (!isRefresh) isLoading = true;
    notifyListeners();
    final res = await api.get('/list-member', queryParameters: form);
    if (!isRefresh) isLoading = false;
    if (res.statusCode == 200) {
      if (res.data['code'] == 0) {
        final convert = res.data['payload'] as List;
        listMember.clear();
        listMember = convert.map((data) => UserModel.fromJson(data)).toList();
      } else {
        listMember.clear();
      }
    } else {
      Utils.messError(res.data['message']);
    }
    notifyListeners();
  }
}

final homeController =
    ChangeNotifierProvider<HomeController>((ref) => HomeController(ref));
