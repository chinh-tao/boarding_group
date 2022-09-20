import 'package:boarding_group/app/common/config.dart';
import 'package:boarding_group/app/widget/button/button_loading.dart';
import 'package:boarding_group/app/widget/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/forgot_pass_controller.dart';

class ForgotPassView extends GetView<ForgotPassController> {
  const ForgotPassView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.handleSetValue();
    return SingleChildScrollView(
      child: SizedBox(
          width: Get.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() => CustomInput(
                  title: '',
                  controller: controller.inputCode,
                  maxLength: 12,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  hintText: 'căn cước hoặc hộ chiếu',
                  err: controller.listError[0])),
              const SizedBox(height: 17),
              Obx(() => CustomInput(
                  title: '',
                  controller: controller.inputEmail,
                  hintText: 'tài khoản email',
                  err: controller.listError[1])),
              const SizedBox(height: 35),
              Obx(() => ButtonLoading(
                  height: 50,
                  width: 170,
                  sizeContent: 16,
                  colors: kIndigoBlueColor900,
                  isLoading: controller.isLoading.value,
                  titleButton: 'GỬI',
                  onPressed: () async => await controller.submit()))
            ],
          )),
    );
  }
}
