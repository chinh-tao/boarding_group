import 'package:boarding_group/app/common/config.dart';
import 'package:boarding_group/app/common/primary_style.dart';
import 'package:boarding_group/app/modules/register/controllers/register_controller.dart';
import 'package:boarding_group/app/widget/button/button_loading.dart';
import 'package:boarding_group/app/widget/button/second_outlined_button.dart';
import 'package:boarding_group/app/widget/button/second_text_button.dart';
import 'package:boarding_group/app/widget/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BodyRegister extends StatelessWidget {
  const BodyRegister({Key? key, required this.controller}) : super(key: key);

  final RegisterController controller;

  Widget showImage() {
    return Obx(() {
      if (controller.isLoadImage.value) {
        return const CircularProgressIndicator(color: kPrimaryColor);
      }
      return handleImagePicker(controller);
    });
  }

  Color? showBackgroundInput(bool value) {
    if (value) {
      return kGreyColor400;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 80),
            showImage(),
            const SizedBox(height: 30),
            GetBuilder<RegisterController>(builder: (_) {
              return Column(
                children: [
                  CustomInput(
                    controller: _.inputCode,
                    title: 'Căn cước/chứng minh thư',
                    keyboardType: TextInputType.number,
                    maxLength: 12,
                    readOnly: _.isEditText[0],
                    background: showBackgroundInput(_.isEditText[0]),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    button: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: SecondOutlinedButton(
                          title: 'Kiểm tra',
                          sizeText: 17,
                          isLoading: _.isLoadUser.value,
                          background: showBackgroundInput(_.isEditText[0]),
                          height: 49,
                          strokeWidth: 2.7,
                          onPressed: () async => await _.handleCheckUser()),
                    ),
                    err: _.listError[0],
                  ),
                  const SizedBox(height: 8),
                  CustomInput(
                    readOnly: true,
                    controller: _.inputName,
                    hintText: 'tên người dùng',
                    background: showBackgroundInput(_.isEditText[0]),
                    title: '',
                    err: '',
                  ),
                  const SizedBox(height: 15),
                  CustomInput(
                    controller: _.inputEmail,
                    readOnly: _.isEditText[1],
                    title: 'Tài khoản email',
                    background: showBackgroundInput(_.isEditText[1]),
                    err: _.listError[1],
                  ),
                  const SizedBox(height: 40),
                  Obx(() => ButtonLoading(
                      height: 55,
                      width: 170,
                      sizeContent: 18,
                      colors: _.isEditText[1] ? kGreyColor400 : kPrimaryColor,
                      isLoading: _.isLoading.value,
                      titleButton: "Đăng ký",
                      onPressed: () async => await _.submit())),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SecondTextButton(
                        onPressed: () => Get.back(),
                        iconLeft: Icons.arrow_back_ios,
                        title: 'Đăng nhập'),
                  )
                ],
              );
            })
          ],
        ),
      ),
    );
  }

  Widget handleImagePicker(RegisterController controller) {
    return FutureBuilder<void>(
        future: controller.retrieveLostData(),
        builder: (context, snapshort) {
          switch (snapshort.connectionState) {
            case ConnectionState.none:
              return const CircularProgressIndicator(color: kPrimaryColor);
            case ConnectionState.waiting:
              return const CircularProgressIndicator(color: kPrimaryColor);
            case ConnectionState.done:
              return showImagePicker();
            default:
              if (snapshort.hasError) {
                return Text("Pick image/image error: ${snapshort.error}",
                    style: PrimaryStyle.bold(color: kRedColor400, 16));
              } else {
                return const CircularProgressIndicator(color: kPrimaryColor);
              }
          }
        });
  }

  Widget showImagePicker() {
    return GestureDetector(
      onTap: () => controller.showModalSheet(),
      child: Obx(() => CircleAvatar(
            foregroundImage: controller.fileImage.value.path != ''
                ? Image.file(controller.fileImage.value, height: 170).image
                : null,
            radius: 110,
            backgroundColor: kGreyColor400,
            child: controller.fileImage.value.path == ''
                ? const Icon(Icons.add_a_photo, color: Colors.black, size: 50)
                : const SizedBox.shrink(),
          )),
    );
  }
}
