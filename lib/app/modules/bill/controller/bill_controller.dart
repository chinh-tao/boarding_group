import 'dart:js';

import 'package:boarding_group/app/common/api.dart';
import 'package:boarding_group/app/common/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import '../../../common/auth.dart';
import '../../../common/utils.dart';
import '../../../model/bill_model.dart';
import '../view/components/dialog_month.dart';

class BillController extends ChangeNotifier {
  var listBill = <BillModel>[];
  var isLoading = false;
  var status = 0;
  var date = DateFormat("yyyy-MM").format(DateTime.now());

  void initData(WidgetRef ref) {
    // date = format.format(DateTime.now());
    // print("object123: $date");
    loadDataBill(ref, isRefresh: true);
  }

  void loadDataBill(ref, {bool isRefresh = false}) async {
    final form = <String, dynamic>{
      "room": ref.watch(Auth.user).getRoomNumber,
      "month": date
    };

    if (isRefresh) isLoading = true;
    notifyListeners();
    final res = await api.get('/list-bill', queryParameters: form);
    if (isRefresh) isLoading = false;
    if (res.statusCode == 200 && res.data["code"] == 0) {
      final listData = res.data["payload"] as List;
      listBill = listData.map((data) => BillModel.fromJson(data)).toList();
      if (listBill[0].payment != null) {
        final listPayment = listBill[0].payment!;
        for (int i = 0; i < listPayment.length; i++) {
          if (listPayment[i].name == ref.watch(Auth.user).getUserName) {
            status = listPayment[i].status!;
            print("object123: $status");
          }
        }
      }
    } else {
      Utils.messError(res.data["message"]);
    }
    notifyListeners();
  }

  void showMonth(ref) async {
    final year = int.parse(date.substring(0, 4));
    final month = int.parse(date.substring(5, 7));
    print("object123: $year");
    print("object1234: $month");

    DateTime? pickedMonth = await showMonthPicker(
      context: navKey.currentContext!,
      initialDate: DateTime(DateTime.now().year, DateTime.now().month),
      firstDate: DateTime(2018),
      lastDate: DateTime(DateTime.now().year, DateTime.now().month),
    );
    if (pickedMonth != null) {
      date = DateFormat("yyyy-MM").format(pickedMonth);
      print("object12: $date");
      notifyListeners();
      loadDataBill(ref, isRefresh: true);
    }
  }

  void showDialogMonth() {
    showDialog(
        context: navKey.currentContext!,
        builder: (context) {
          return const DialogMonth();
        });
  }
}
