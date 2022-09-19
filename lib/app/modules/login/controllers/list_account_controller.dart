import 'package:boarding_group/app/common/api.dart';
import 'package:boarding_group/app/model/user_model.dart';
import 'package:boarding_group/app/modules/auth/auth_controller.dart';
import 'package:boarding_group/app/modules/change_pass/controllers/change_pass_controller.dart';
import 'package:boarding_group/app/modules/change_pass/views/verifi_code_screen.dart';
import 'package:boarding_group/app/modules/login/views/body/body_bottom_sheet.dart';
import 'package:boarding_group/app/routes/app_pages.dart';
import 'package:boarding_group/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ListAccountController extends GetxController
    with GetTickerProviderStateMixin {
  final isLoading = false.obs;

  final _log = Logger();
  final AuthController authController = Get.find();
  final ChangePassController changePassController = Get.find();
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
    double maxHeight =
        user.deviceMobi!.contains(authController.device.value) ? 110 : 150;
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: Get.context!,
        constraints: BoxConstraints(maxHeight: maxHeight),
        builder: (context) {
          return BodyBottomSheet(
            isHideMenu: user.deviceMobi!.contains(authController.device.value),
            removeAccount: () async {
              Get.back();
              showRemoveAccount(user);
            },
            user: user,
            changePass: () {
              Get.back();
              changePassController.clearDataVerifiCode();
              handleVerifiCode(user);
            },
          );
        });
  }

  void handleVerifiCode(UserModel user, {String? change}) {
    showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: VerifiCodeScreen(userModel: user, change: change),
          );
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
        Get.toNamed(Routes.LOGIN);
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
}
