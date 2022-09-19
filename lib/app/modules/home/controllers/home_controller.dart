import 'package:boarding_group/app/modules/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../model/player.dart';
import '../../../utils/utils.dart';

class HomeController extends GetxController {
  final AuthController authController = Get.find();
  final _log = Logger();

  final listData = <List<String>>[].obs;
  final listColor = [].obs;
  final count = 16.obs;
  final changeValue = ''.obs;
  final isSuccess = ''.obs;
  final listCount = <int>[0, 0, 0, 0];

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void initData() {
    handleClearData();
    _log.i("TYPE: Auth,\nDATA: ${authController.user.value.id}");
    update();
  }

  void showData(int position, int index) {
    if (listData[position][index].isEmpty) {
      final result = changeValue.value == Player.X ? Player.O : Player.X;
      changeValue.value = result;
      listData[position][index] = result;
      getBoxColor(position, index);

      if (handleWinner(position, index)) {
        showMessagePopup(
            getColorsBackGround, "Player ${changeValue.value} won!");
      } else if (handleEnd()) {
        showMessagePopup(Color(0xffffff9800), "The game is tied!!");
      }
      update();
    }
  }

  void showMessagePopup(Color color, String content) {
    Utils.showMessage(
        text: content,
        color: color,
        alignment: Alignment.centerLeft,
        onPressed: () {
          handleClearData();
          Get.back();
        });
  }

  void getBoxColor(int position, int index) {
    if (changeValue.value == Player.O) {
      listColor[position][index] = Colors.blue;
    } else if (changeValue.value == Player.X) {
      listColor[position][index] = Colors.redAccent;
    }
    update();
  }

  bool handleWinner(int position, int index) {
    var result = 0, count1 = 0, count2 = 0;
    final player = listData[position][index];
    final max = count.value - 1;

    //hàng cùng giá trị
    count1 = index;
    //1.lọc giá trị từ trái sang phải
    while (listData[position][count1] == player) {
      result++;
      if (count1 == max) break;
      count1++;
    }

    //2.lọc giá trị từ phải sang trái
    if (index != 0) {
      count1 = index - 1;
      while (listData[position][count1] == player) {
        result++;
        if (count1 == 0) break;
        count1--;
      }
    }
    if (result == 5) return true;

    //cột cùng giá trị
    result = 0;
    count1 = position;
    //1.lọc giá trị từ trên xuống
    while (listData[count1][index] == player) {
      result++;
      if (count1 == max) break;
      count1++;
    }

    //2.lọc giá trị từ dưới lên
    if (position != 0) {
      count1 = position - 1;
      while (listData[count1][index] == player) {
        result++;
        if (count1 == 0) break;
        count1--;
      }
    }
    if (result == 5) return true;

    //Đường chéo trái cùng giá trị
    //note: hướng lọc giá trị tương tự phần cột
    result = 0;
    count1 = position;
    count2 = index;
    while (listData[count1][count2] == player) {
      result++;
      if (count1 == max || count2 == max) break;
      count1++;
      count2++;
    }

    if (position != 0) count1 = position - 1;
    if (index != 0) count2 = index - 1;
    while (listData[count1][count2] == player) {
      result++;
      if (count1 == 0 || count2 == 0) break;
      count1--;
      count2--;
    }
    if (result == 5) return true;

    //Đường chéo phải cùng giá trị
    //note: hướng lọc giá trị tương tự phần cột
    result = 0;
    count1 = position;
    count2 = index;
    while (listData[count1][count2] == player) {
      result++;
      if (count1 == max || count2 == 0) break;
      count1++;
      count2--;
    }

    if (position != 0) count1 = position - 1;
    if (index != max) count2 = index + 1;
    while (listData[count1][count2] == player) {
      result++;
      if (count1 == 0 || count2 == max) break;
      count1--;
      count2++;
    }
    if (result == 5) return true;

    return false;
  }

  bool handleEnd() =>
      listData.every((values) => values.every((value) => value != ''));

  void handleClearData() {
    isSuccess.value = '';
    changeValue.value = '';
    listData.value = List.generate(
        count.value, (_) => List.generate(count.value, (_) => ""));
    listColor.value = List.generate(
        count.value, (_) => List.generate(count.value, (_) => Colors.white));
    update();
  }

  Color get getColorsBackGround {
    if (changeValue.value == Player.O) {
      return Color(0xffff03a9f4);
    }
    return Color(0xffffef5350);
  }
}
