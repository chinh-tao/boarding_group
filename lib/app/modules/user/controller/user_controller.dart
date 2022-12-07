import 'dart:convert';
import 'dart:io';

import 'package:boarding_group/app/common/auth.dart';
import 'package:boarding_group/app/common/global.dart';
import 'package:boarding_group/app/common/utils.dart';
import 'package:boarding_group/app/modules/home/controllers/home_controller.dart';
import 'package:boarding_group/app/modules/password/views/change_pass_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../widget/custom_bottom_sheet.dart';

class UserController extends ChangeNotifier {
  UserController(this.ref);

  TextEditingController inputID = TextEditingController();
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPhone = TextEditingController();
  TextEditingController inputName = TextEditingController();
  TextEditingController inputRoom = TextEditingController();

  final Ref ref;
  var isLoading = false;
  var listErr = <String>[];
  var fileImage = File("");

  void initData() {
    inputID.text = ref.watch(Auth.user).getID;
    inputEmail.text = ref.watch(Auth.user).getEmail;
    inputPhone.text = ref.watch(Auth.user).getPhone;
    inputName.text = ref.watch(Auth.user).getUserName;
    inputRoom.text = ref.watch(Auth.user).getRoomNumber;
    listErr = List.filled(2, '');
    notifyListeners();
  }

  bool validator() {
    var result = true;
    listErr = List.filled(2, '');
    if (inputEmail.text.trim().isEmpty) {
      listErr[0] = 'thông tin không được để trống';
      result = false;
    } else if (!regexEmail.hasMatch(inputEmail.text)) {
      listErr[0] = 'email không đúng định dạng';
      result = false;
    }

    if (inputPhone.text.trim().isEmpty) {
      listErr[1] = 'thông tin không được để trống';
      result = false;
    }

    if ((inputEmail.text.trim() == ref.watch(Auth.user).getEmail) &&
        (inputPhone.text.trim() == ref.watch(Auth.user).getPhone) &&
        fileImage.path.isEmpty) {
      Utils.messWarning(
          'Không thể cập thông tin khi thông tin chưa được thay đổi.');
      result = false;
    }
    notifyListeners();
    return result;
  }

  Future<void> handleUpdateUser() async {
    Utils.handleUnfocus();
    if (!validator()) return;
    final form = <String, dynamic>{"id": ref.watch(Auth.user).getID};
    if (inputEmail.text.trim() != ref.watch(Auth.user).getEmail) {
      form['email'] = inputEmail.text;
    }
    if (inputPhone.text.trim() != ref.watch(Auth.user).getPhone) {
      form['phone'] = inputPhone.text;
    }
    if (fileImage.path.isNotEmpty) {
      form["images"] = {
        "file": base64Encode(fileImage.readAsBytesSync()),
        "type": Utils.getTypeImage(fileImage.path)
      };
    }
    isLoading = true;
    notifyListeners();
    final res = await api.put('/update-user', data: form);
    isLoading = false;
    notifyListeners();

    if (res.statusCode == 200 && res.data["code"] == 0) {
      Utils.messSuccess(res.data['message']);
      await ref.read(homeController.notifier).getListMember();
      final member = ref
          .watch(homeController)
          .listMember
          .where((data) => data.id == ref.watch(Auth.user).getID)
          .toList();
      ref.read(Auth.user.notifier).state = member[0];
    } else {
      Utils.messError(res.data['message']);
    }
  }

  void showChangePass() {
    showDialog(
        context: navKey.currentContext!,
        builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: const ChangePassView()));
  }

  void showModalSheet() {
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
}

final userController = ChangeNotifierProvider.autoDispose<UserController>(
    (ref) => UserController(ref));
