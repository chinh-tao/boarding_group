import 'package:boarding_group/app/common/api.dart';
import 'package:boarding_group/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassController extends GetxController {
  TextEditingController inputCode = TextEditingController();
  TextEditingController inputEmail = TextEditingController();

  final listError = ["", ""].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
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

  bool get validator {
    var result = true;
    listError.value = ["", ""];
    if (inputCode.text.isEmpty) {
      listError[0] = "vui lòng không để trống thông tin";
      result = false;
    }
    if (inputEmail.text.trim().isEmpty) {
      listError[1] = "vui lòng không để trống thông tin";
      result = false;
    } else if (!inputEmail.text.trim().isEmail) {
      listError[1] = "địa chỉ email không hợp lệ";
      result = false;
    }
    return result;
  }

  Future<void> submit() async {
    if (!validator) return;
    final form = {"id": inputCode.text, "email": inputEmail.text.trim()};
    isLoading(true);
    final res = await api.put('/forgot-pass', data: form);
    isLoading(false);
    if (res.statusCode == 200 && res.data["code"] == 0) {
      Get.back();
      Utils.messSuccess(res.data["message"]);
    } else {
      Utils.messError(res.data['message']);
    }
  }

  void handleSetValue() {
    inputCode.clear();
    inputEmail.clear();
    isLoading(false);
    listError.value = ["", ""];
  }
}
