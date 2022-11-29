import 'package:boarding_group/app/common/auth.dart';
import 'package:boarding_group/app/common/global.dart';
import 'package:boarding_group/app/model/admin_model.dart';
import 'package:boarding_group/app/model/user_model.dart';
import 'package:boarding_group/app/modules/forgot_pass/views/forgot_pass_view.dart';
import 'package:boarding_group/app/routes/app_pages.dart';
import 'package:boarding_group/app/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class LoginController extends ChangeNotifier {
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPass = TextEditingController();

  var arguments = <String, dynamic>{};
  var userModel = UserModel();
  var isLoading = false;
  var listErrLogin = ["", ""];
  var isHidePass = true;

  final _log = Logger();

  void initData(context) {
    clearDataLogin();
    arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    if (arguments['category'] == '1') {
      userModel = arguments['user'];
      inputEmail.text = userModel.email!;
      inputPass.text = 'Luanlq@123';
    }
    notifyListeners();
  }

  void close() {
    inputEmail.clear();
    inputPass.clear();
    arguments = <String, dynamic>{};
    userModel = UserModel();
    isLoading = false;
    listErrLogin = ["", ""];
    isHidePass = true;
  }

  bool get validatorLogin {
    var result = true;
    listErrLogin = ["", ""];
    if (inputEmail.text.trim().isEmpty) {
      listErrLogin[0] = 'thông tin không được để trống';
      result = false;
    } else if (!regexEmail.hasMatch(inputEmail.text.trim())) {
      listErrLogin[0] = 'email không đúng định dạng';
      result = false;
    }
    if (inputPass.text.trim().isEmpty) {
      listErrLogin[1] = 'mật khẩu không được để trống';
      result = false;
    } else if (inputPass.text.length > 50) {
      listErrLogin[1] = 'mật khẩu không lớn quá 8 kí tự';
      result = false;
    }
    notifyListeners();
    return result;
  }

  Future<void> submit(WidgetRef ref) async {
    if (!validatorLogin) return;

    final form = {
      "email": inputEmail.text,
      "pass": inputPass.text,
      "device_mobi": ref.watch(Auth.device)
    };
    isLoading = true;
    final res = await api.post('/login', data: form);
    isLoading = false;

    if (res.statusCode == 200 && res.data['code'] == 0) {
      ref.read(Auth.user.notifier).state =
          UserModel.fromJson(res.data['payload']['infor_user']);
      box.write('idBranch', res.data['payload']['id_branch']);
      ref.read(Auth.admin.notifier).state =
          AdminModel.fromJson(res.data['payload']);
      Navigator.of(navKey.currentContext!)
          .pushNamedAndRemoveUntil(Routes.ROOT, (route) => false);
    } else {
      Utils.messError(res.data['message']);
    }
    notifyListeners();
  }

  void clearDataLogin() {
    inputEmail.clear();
    inputPass.clear();
  }

  void showForgotPass() {
    showDialog(
        context: navKey.currentContext!,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              content: const ForgotPassView());
        });
  }

  void handleShowPass() {
    isHidePass = !isHidePass;
    notifyListeners();
  }
}

var loginController = ChangeNotifierProvider.autoDispose<LoginController>(
    (ref) => LoginController());
