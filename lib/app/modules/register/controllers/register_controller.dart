import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:boarding_group/app/common/global.dart';
import 'package:boarding_group/app/widget/custom_bottom_sheet.dart';
import 'package:boarding_group/app/routes/app_pages.dart';
import 'package:boarding_group/app/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import '../../../common/auth.dart';

class RegisterController extends ChangeNotifier {
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputCode = TextEditingController();
  TextEditingController inputName = TextEditingController();

  final isLoadImage = false;
  var isLoading = false;
  var listError = ["", ""];

  final _log = Logger();
  var fileImage = File("");

  Timer? time;

  bool get validator {
    var result = true;
    listError = ["", ""];

    if (inputCode.text.trim().isEmpty) {
      listError[0] = "vui lòng không để trống thông tin";
      result = false;
    } else if (inputCode.text.trim().length < 12) {
      listError[0] = "không khớp với định dạng";
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

  void submit(WidgetRef ref) async {
    if (!validator) return;
    await registerAccount(ref);
  }

  void showModalSheet(WidgetRef ref) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: navKey.currentContext!,
        constraints: const BoxConstraints(maxHeight: 150),
        builder: (context) {
          return CustomBottomSheet(imageCamera: () async {
            fileImage = await Utils.handlePickerImage(ImageSource.camera);
            notifyListeners();
          }, pickerImage: () async {
            fileImage = await Utils.handlePickerImage(ImageSource.gallery);
            notifyListeners();
          }, removeAvatar: () {
            Navigator.of(context).pop();
            fileImage = File('');
            notifyListeners();
          });
        });
  }

  Future<void> registerAccount(WidgetRef ref) async {
    final form = <String, dynamic>{
      "id": inputCode.text,
      "email": inputEmail.text,
      "device_mobi": ref.watch(Auth.device)
    };
    if (fileImage.path != '') {
      form["images"] = {
        "file": base64Encode(fileImage.readAsBytesSync()),
        "type": Utils.getTypeImage(fileImage.path)
      };
    }
    isLoading = true;
    notifyListeners();
    final res = await api.post('/register', data: form);
    isLoading = false;
    notifyListeners();
    if (res.statusCode == 200 && res.data['code'] == 0) {
      navKey.currentState!.pushNamedAndRemoveUntil(
          Routes.LOGIN, (route) => false,
          arguments: {'category': '0'});
    } else {
      Utils.messError(res.data['message']);
    }
  }

  Future<void> handleCheckUser(String value) async {
    final form = {"id": value};
    final res = await api.post('/check-user', data: form);
    if (res.statusCode == 200 && res.data['code'] == 0) {
      inputName.text = res.data['payload'].toString();
    } else if (res.data['code'] == 400) {
      inputName.clear();
    } else {
      Utils.messError(res.data['message']);
    }
    notifyListeners();
  }

  void handleChangeInputName(String value) {
    time = Timer(const Duration(milliseconds: 200), () {
      handleCheckUser(value);
    });
  }
}

final registerController =
    ChangeNotifierProvider.autoDispose<RegisterController>(
        (ref) => RegisterController());
