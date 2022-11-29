import 'package:boarding_group/app/common/global.dart';
import 'package:boarding_group/app/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPassController extends ChangeNotifier {
  TextEditingController inputCode = TextEditingController();
  TextEditingController inputEmail = TextEditingController();

  var listError = ["", ""];
  var isLoading = false;

  bool get validator {
    var result = true;
    listError = ["", ""];
    if (inputCode.text.isEmpty) {
      listError[0] = "vui lòng không để trống thông tin";
      result = false;
    }
    if (inputEmail.text.trim().isEmpty) {
      listError[1] = "vui lòng không để trống thông tin";
      result = false;
    } else if (!regexEmail.hasMatch(inputEmail.text.trim())) {
      listError[1] = "địa chỉ email không hợp lệ";
      result = false;
    }
    notifyListeners();
    return result;
  }

  Future<void> submit() async {
    if (!validator) return;
    final form = {"id": inputCode.text, "email": inputEmail.text.trim()};
    isLoading = true;
    final res = await api.put('/forgot-pass', data: form);
    isLoading = false;
    if (res.statusCode == 200 && res.data["code"] == 0) {
      Navigator.of(navKey.currentContext!).pop();
      Utils.messSuccess(res.data["message"]);
    } else {
      Utils.messError(res.data['message']);
    }
    notifyListeners();
  }

  void handleSetValue() {
    inputCode.clear();
    inputEmail.clear();
    isLoading = false;
    listError = ["", ""];
    notifyListeners();
  }
}

final forgotPassController =
    ChangeNotifierProvider.autoDispose<ForgotPassController>(
        (ref) => ForgotPassController());
