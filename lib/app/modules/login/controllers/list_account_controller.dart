import 'package:boarding_group/app/common/api.dart';
import 'package:boarding_group/app/model/user_model.dart';
import 'package:boarding_group/app/modules/auth/auth_controller.dart';
import 'package:boarding_group/app/modules/forgot_pass/views/forgot_pass_view.dart';
import 'package:boarding_group/app/modules/login/views/body/body_bottom_sheet.dart';
import 'package:boarding_group/app/routes/app_pages.dart';
import 'package:boarding_group/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ListAccountController extends GetxController
    with GetTickerProviderStateMixin {
  final forgotPassErr = "".obs;
  final isLoading = false.obs;
  final isHideMenu = false.obs;

  final _log = Logger();
  final AuthController authController = Get.find();
  late final AnimationController _aniController =
      AnimationController(duration: const Duration(seconds: 2), vsync: this)
        ..repeat(reverse: false);
  late final Animation<double> animation =
      CurvedAnimation(parent: _aniController, curve: Curves.slowMiddle);

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
    _aniController.dispose();
    super.onClose();
  }

  void showBottomSheet(UserModel user) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: Get.context!,
        constraints: const BoxConstraints(maxHeight: 110), //110
        builder: (context) {
          return BodyBottomSheet(
              removeAccount: () async {
                Get.back();
                showRemoveAccount(user);
              },
              user: user);
        });
  }

  Future<void> handleRemoveAccount(String email) async {
    final form = {'email': email, 'device_mobi': authController.device.value};

    isLoading(true);
    final res = await api.delete('/remove-account', data: form);
    isLoading(false);
    if (res.statusCode == 200 && res.data['code'] == 0) {
      authController.listUser
          .removeWhere((data) => data.email!.contains(email));
      if (authController.listUser.isNotEmpty) {
        Utils.messSuccess(res.data['message']);
      } else {
        Get.toNamed(Routes.LOGIN, parameters: {'category': '0'});
      }
    } else {
      Utils.messError(res.data['message']);
    }
  }

  void showRemoveAccount(UserModel user) async {
    Utils.showMessPopup(
        content: 'Bạn có muốn gỡ tài khoản này?',
        onPressed: () async {
          Get.back();
          await handleRemoveAccount(user.email!);
        });
  }

  void showForgotPass() {
    isHideMenu.value = false;
    showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: const ForgotPassView(),
          );
        });
  }
}
