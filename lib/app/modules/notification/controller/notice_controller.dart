import 'package:boarding_group/app/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/global.dart';
import '../../../model/notice_model.dart';

class NoticeController extends ChangeNotifier {
  var listNotice = <NoticeModel>[];
  var isLoading = false;

  void loadNotice({bool isRefresh = false}) async {
    if (!isRefresh) isLoading = true;
    notifyListeners();
    final res = await api.get('/list-notice');
    if (!isRefresh) isLoading = false;
    if (res.statusCode == 200) {
      if (res.data['code'] == 0) {
        final convert = res.data['payload'] as List;
        listNotice = convert
            .map((data) => NoticeModel.fromJson(data))
            .toList()
            .reversed
            .toList();
      } else {
        listNotice.clear();
      }
    } else {
      Utils.messError(res.data['message']);
    }
    notifyListeners();
  }
}

final noticeController =
    ChangeNotifierProvider<NoticeController>((ref) => NoticeController());
