import 'package:boarding_group/app/common/auth.dart';
import 'package:boarding_group/app/common/global.dart';
import 'package:boarding_group/app/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangePassController extends ChangeNotifier {
  TextEditingController inputOldPass = TextEditingController();
  TextEditingController inputConfirm = TextEditingController();
  TextEditingController inputNewPass = TextEditingController();

  var isLoading = false;
  var listErr = <String>["", "", ""];
  var regexPass = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[a-zA-Z0-9$@!%*?&#^+=-_]{8,16}$');

  bool get validator {
    var result = true;
    listErr = List.filled(3, '');
    if (inputOldPass.text.trim().isEmpty) {
      listErr[0] = "thông tin không được để trống";
      result = false;
    }

    if (inputNewPass.text.trim().isEmpty) {
      listErr[1] = "thông tin không được để trống";
      result = false;
    } else if (!regexPass.hasMatch(inputNewPass.text)) {
      listErr[1] =
          "mật khẩu phải có 8-16 ký tự chữ và số bao gồm cả chữ hoa, chữ thường và ký tự đặc biệt";
      result = false;
    }

    if (inputConfirm.text.trim().isEmpty) {
      listErr[2] = "thông tin không được để trống";
      result = false;
    } else if (inputConfirm.text != inputNewPass.text.trim()) {
      listErr[2] = "mật khẩu không chính xác";
      result = false;
    }
    notifyListeners();
    return result;
  }

  Future<void> handleChangePass(WidgetRef ref) async {
    if (!validator) return;

    final form = {
      "old_pass": inputOldPass.text.trim(),
      "new_pass": inputConfirm.text,
      "id": ref.watch(Auth.user).getID
    };

    isLoading = true;
    notifyListeners();
    final res = await api.put('/update-user', data: form);
    isLoading = false;
    notifyListeners();

    if (res.statusCode == 200 && res.data['code'] == 0) {
      navKey.currentState!.pop();
      Utils.messSuccess(res.data['message']);
    } else {
      Utils.messError(res.data['message']);
    }
  }
}

final changePassController =
    ChangeNotifierProvider.autoDispose<ChangePassController>(
        (ref) => ChangePassController());
