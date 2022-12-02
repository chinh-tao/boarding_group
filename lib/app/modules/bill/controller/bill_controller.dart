import 'dart:convert';
import 'dart:io';
import 'package:boarding_group/app/common/global.dart';
import 'package:boarding_group/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import '../../../common/auth.dart';
import '../../../common/utils.dart';
import '../../../model/bill_model.dart';
import '../../../routes/app_pages.dart';
import '../../../widget/custom_bottom_sheet.dart';

class BillController extends ChangeNotifier {
  var listBill = <BillModel>[];
  var isLoading = false;
  var isLoadingButton = false;
  var status = 0;
  var memberNumber = 0;
  var date = '';
  var userName = '';
  var room = '';
  var image = '';
  var category = 'Tiền mặt';
  var categoryList = ['Tiền mặt', 'Chuyển khoản'];
  var format = DateFormat("yyyy-MM");
  var fileImage = File("");

  void initData(WidgetRef ref) async {
    date = format.format(DateTime.now());
    isClear();
    userName = ref.watch(Auth.user).getUserName;
    room = ref.watch(Auth.user).getRoomNumber;
    memberNumber = ref
        .watch(homeController)
        .listMember
        .where((e) => e.roomNumber == ref.watch(Auth.user).getRoomNumber)
        .length;

    await loadDataBill(isRefresh: true);
  }

  void isClear() {
    category = 'Tiền mặt';
    fileImage = File("");
    notifyListeners();
  }

  Future<void> loadDataBill({bool isRefresh = false}) async {
    listBill.clear();
    notifyListeners();
    final form = <String, dynamic>{"room": room, "month": date};

    if (isRefresh) isLoading = true;
    notifyListeners();
    final res = await api.get('/list-bill', queryParameters: form);
    if (isRefresh) isLoading = false;
    if (res.statusCode == 200 && res.data["code"] == 0) {
      final listData = res.data["payload"] as List;
      listBill = listData.map((data) => BillModel.fromJson(data)).toList();
      print("object123: ${listBill[0].payment}");
      print("object123: ${listBill[0].payment!.isNotEmpty}");
      if (listBill[0].payment!.isNotEmpty) {
        final listPayment = listBill[0].payment!;
        for (int i = 0; i < listPayment.length; i++) {
          if (listPayment[i].name == userName) {
            status = listPayment[i].status!;
            category = listPayment[i].getCategory;
            image = listPayment[i].getImage;
            notifyListeners();
          }
        }
      } else {
        isClear();
        status = 0;
        image = "";
        notifyListeners();
      }
      print("object: $image");
      print("object1: $status");
      print("object2: $category");
    } else {
      Utils.messError(res.data["message"]);
    }
    notifyListeners();
  }

  void showMonth() async {
    final year = int.parse(date.substring(0, 4));
    final month = int.parse(date.substring(5, 7));

    DateTime? pickedMonth = await showMonthPicker(
        context: navKey.currentContext!,
        initialDate: DateTime(year, month),
        firstDate: DateTime(2018),
        lastDate: DateTime(DateTime.now().year, DateTime.now().month),
        locale: const Locale('vi'));
    if (pickedMonth != null) {
      date = format.format(pickedMonth);
      notifyListeners();
    }
  }

  void billOnChanged(String value) {
    category = value;
    if (category == "Tiền mặt") {
      fileImage = File('');
    }
    notifyListeners();
  }

  void nextDetail(int index) {
    if (image.isEmpty) {
      billOnChanged("Tiền mặt");
    }
    navKey.currentState!.pushNamed(Routes.DETAIL_BILL, arguments: index);
  }

  Future<void> submitPayment() async {
    if (category == "Chuyển khoản" && fileImage.path == "") {
      return;
    }

    final form = <String, dynamic>{
      "name": userName,
      "category": category == "Tiền mặt" ? 0 : 1,
      "date": DateFormat("yyyy-MM-dd").format(DateTime.now()),
      "id": listBill[0].billId
    };

    if (fileImage.path != '') {
      form["images"] = {
        "file": base64Encode(fileImage.readAsBytesSync()),
        "type": Utils.getTypeImage(fileImage.path)
      };
    }

    isLoadingButton = true;
    notifyListeners();
    final res = await api.post('/payment', data: form);
    if (res.statusCode == 200 && res.data['code'] == 0) {
      await loadDataBill();
      isLoadingButton = false;
      Utils.messSuccess(res.data['message']);
    } else {
      Utils.messError(res.data['message']);
    }
    notifyListeners();
  }

  Future<void> showModalSheet(WidgetRef ref) async {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: navKey.currentContext!,
        constraints: const BoxConstraints(maxHeight: 103),
        builder: (context) {
          return CustomBottomSheet(
            imageCamera: () async {
              fileImage = await Utils.handlePickerImage(ImageSource.camera);
              notifyListeners();
            },
            pickerImage: () async {
              fileImage = await Utils.handlePickerImage(ImageSource.gallery);
              notifyListeners();
            },
          );
        });
  }
}

final billController =
    ChangeNotifierProvider<BillController>((ref) => BillController());
