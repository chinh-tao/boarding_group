import 'package:boarding_group/app/common/config.dart';
import 'package:boarding_group/app/common/primary_style.dart';
import 'package:boarding_group/app/routes/app_pages.dart';
import 'package:boarding_group/app/widget/button/button_loading.dart';
import 'package:boarding_group/app/widget/button/second_text_button.dart';
import 'package:boarding_group/app/widget/custom_input.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widget/image/custom_image_default.dart';
import '../../../widget/image/custom_image_loading.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 80),
              getImage(),
              const SizedBox(height: 10),
              Text(getTitle,
                  textAlign: TextAlign.center,
                  style: PrimaryStyle.bold(color: kPrimaryColor, 33)),
              const SizedBox(height: 40),
              if (Get.parameters['category'] != '1') ...[
                Obx(() => CustomInput(
                      controller: controller.inputEmail,
                      title: 'Tài khoản email',
                      err: controller.listErrLogin[0],
                    )),
                const SizedBox(height: 15),
              ],
              Obx(() => CustomInput(
                    controller: controller.inputPass,
                    title: 'Mật khẩu',
                    obscureText: controller.isHidePass.value,
                    icons: IconButton(
                        icon: Icon(showIcon(controller.isHidePass.value),
                            color: kPrimaryColor),
                        onPressed: () => controller
                            .isHidePass(!controller.isHidePass.value)),
                    err: controller.listErrLogin[1],
                  )),
              const SizedBox(height: 40),
              Obx(() => ButtonLoading(
                  height: 55,
                  width: 170,
                  sizeContent: 18,
                  isLoading: controller.isLoadingLogin.value,
                  titleButton: "Đăng nhập",
                  onPressed: () async => await controller.submit())),
              const SizedBox(height: 22),
              if (Get.parameters['category'] == '0') ...[
                Align(
                  alignment: Alignment.centerRight,
                  child: SecondTextButton(
                      onPressed: () => Get.toNamed(Routes.REGISTER),
                      title: 'Đăng ký tài khoản',
                      iconRight: Icons.arrow_forward_ios),
                )
              ] else ...[
                if (Get.parameters['category'] != '') ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SecondTextButton(
                        onPressed: () => Get.back(),
                        title: 'Đổi tài khoản',
                        iconLeft: Icons.arrow_back_ios),
                  )
                ]
              ],
            ],
          ),
        ),
      ),
    );
  }

  String get getTitle {
    if (Get.parameters['category'] == '1') {
      return controller.userModel.value.userName!;
    }
    return 'Spending Management';
  }

  IconData showIcon(bool value) {
    if (value) {
      return Icons.visibility_off_outlined;
    }
    return Icons.visibility_outlined;
  }

  Widget getImage() {
    if (Get.parameters['category'] == '1') {
      if (controller.userModel.value.images == null) {
        return CustomImageDefault(
            sizeText: 90,
            height: 200,
            width: 200,
            content: controller.userModel.value.userName![0]);
      }
      return CachedNetworkImage(
        imageUrl: controller.userModel.value.images!,
        imageBuilder: (context, imageProvider) => Container(
          width: 200.0,
          height: 200.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (context, url) => CustomImageLoading(
            height: 200,
            width: 200,
            sizeText: 40,
            animation: controller.animation),
        errorWidget: (context, url, error) => const CustomImageDefault(
            content: "null", backgroundColor: kRedColor400),
      );
    }
    return Image.asset('assets/images/logo.png', height: 200);
  }
}
