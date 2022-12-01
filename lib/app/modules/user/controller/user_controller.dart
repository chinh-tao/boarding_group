import 'package:boarding_group/app/common/auth.dart';
import 'package:boarding_group/app/common/global.dart';
import 'package:boarding_group/app/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserController extends ChangeNotifier {
  TextEditingController inputID = TextEditingController();
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPhone = TextEditingController();
  TextEditingController inputName = TextEditingController();
  TextEditingController inputRoom = TextEditingController();

  var isLoading = false;

  void initData(WidgetRef ref) {
    inputID.text = ref.watch(Auth.user).getID;
    inputEmail.text = ref.watch(Auth.user).getEmail;
    inputPhone.text = ref.watch(Auth.user).getPhone;
    inputName.text = ref.watch(Auth.user).getUserName;
    inputRoom.text = ref.watch(Auth.user).getRoomNumber;
    notifyListeners();
  }

  // bool validator(WidgetRef ref) {

  // }

  Future<void> handleUpdateUser(WidgetRef ref) async {
    final form = {"id": ref.watch(Auth.user).getID};
    if (inputEmail.text.trim() != ref.watch(Auth.user).getEmail) {
      form['email'] = inputEmail.text.trim();
    }
    if (inputPhone.text.trim() != ref.watch(Auth.user).getPhone) {
      form['phone'] = inputPhone.text.trim();
    }
    isLoading = true;
    notifyListeners();
    final res = await api.put('/update-user', data: form);
    isLoading = false;
    notifyListeners();

    if (res.statusCode == 200 && res.data["code"] == 0) {
      ref.read(Auth.user.notifier).state.email = inputEmail.text.trim();
      Utils.messSuccess(res.data['message']);
    } else {
      Utils.messError(res.data['message']);
    }
  }
}

final userController =
    ChangeNotifierProvider<UserController>((ref) => UserController());
