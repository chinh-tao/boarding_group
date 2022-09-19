import 'package:boarding_group/app/common/api.dart';
import 'package:boarding_group/app/model/user_model.dart';
import 'package:boarding_group/app/modules/auth/auth_controller.dart';
import 'package:boarding_group/app/routes/app_pages.dart';
import 'package:boarding_group/app/utils/utils.dart';
import 'package:boarding_group/app/widget/body/forgot_pass.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class LoginController extends GetxController with GetTickerProviderStateMixin {
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPass = TextEditingController();
  TextEditingController inputForgotPass = TextEditingController();

  final userModel = UserModel().obs;
  final isLoadingLogin = false.obs;
  final isLoadingForgotPass = false.obs;
  final listErrLogin = ["", ""].obs;
  final isHidePass = true.obs;
  final forgotPassErr = "".obs;

  final _log = Logger();
  final AuthController authController = Get.find();
  late final AnimationController _aniController =
      AnimationController(duration: const Duration(seconds: 2), vsync: this)
        ..repeat(reverse: false);
  late final Animation<double> animation =
      CurvedAnimation(parent: _aniController, curve: Curves.slowMiddle);

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

  void initData() async {
    if (Get.parameters['category'] == '1') {
      userModel.value = Get.arguments['user'];
      inputEmail.text = userModel.value.email!;
    }
  }

  bool get validatorLogin {
    var result = true;
    listErrLogin.value = ["", ""];
    if (inputEmail.text.trim().isEmpty) {
      listErrLogin[0] = 'thông tin không được để trống';
      result = false;
    } else if (!inputEmail.text.isEmail) {
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
    return result;
  }

  bool get validatorForgotPass {
    var result = true;
    forgotPassErr.value = '';
    if (inputForgotPass.text.trim().isEmpty) {
      forgotPassErr.value = 'thông tin không được để trống';
      result = false;
    } else if (!inputForgotPass.text.isEmail) {
      forgotPassErr.value = 'email không đúng định dạng';
      result = false;
    }
    return result;
  }

  Future<void> submit() async {
    if (!validatorLogin) return;

    final form = {
      "email": inputEmail.text,
      "pass": inputPass.text,
      "device_mobi": authController.device.value
    };
    isLoadingLogin.value = true;
    final res = await api.post('/login', data: form);
    isLoadingLogin.value = false;

    if (res.statusCode == 200 && res.data['code'] == 0) {
      authController.user.value = UserModel.fromJson(res.data['payload']);
      Get.offAllNamed(Routes.HOME);
    } else {
      Utils.messError(res.data['message']);
    }
  }

  void clearDataLogin() {
    inputEmail.clear();
    inputPass.clear();
  }

  void showForgotPass() {
    inputForgotPass.clear();
    isLoadingForgotPass(false);
    showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Obx(() => ForgotPass(
                textController: inputForgotPass,
                isLoading: isLoadingForgotPass.value,
                error: forgotPassErr.value,
                onPressed: () {
                  if (!validatorForgotPass) return;
                })),
          );
        });
  }
}
