import 'package:boarding_group/app/common/config.dart';
import 'package:boarding_group/app/modules/change_pass/controllers/change_pass_controller.dart';
import 'package:boarding_group/app/widget/button/button_loading.dart';
import 'package:boarding_group/app/widget/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePassScreen extends StatelessWidget {
  const ChangePassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePassController>(builder: (_) {
      return SingleChildScrollView(
        child: SizedBox(
          width: Get.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomInput(
                  title: 'Mật khẩu mới',
                  controller: _.inputPassNew,
                  err: _.listErrChange[0],
                  obscureText: _.isHidePass.value,
                  icons: IconButton(
                      icon: Icon(showIcon(_.isHidePass.value),
                          color: kPrimaryColor),
                      onPressed: () {
                        _.isHidePass(!_.isHidePass.value);
                        _.update();
                      })),
              const SizedBox(height: 17),
              CustomInput(
                  title: 'Xác nhận mật khẩu',
                  controller: _.inputConfirmPass,
                  obscureText: true,
                  err: _.listErrChange[1]),
              const SizedBox(height: 25),
              Obx(() => ButtonLoading(
                  height: 50,
                  width: 170,
                  colors: kIndigoBlueColor900,
                  sizeContent: 16,
                  isLoading: _.loadingChange.value,
                  titleButton: 'Gửi yêu cầu',
                  onPressed: () async => await _.handleChangePass())),
              const SizedBox(height: 10)
            ],
          ),
        ),
      );
    });
  }

  IconData showIcon(bool value) {
    if (value) {
      return Icons.visibility_off_outlined;
    }
    return Icons.visibility_outlined;
  }
}
