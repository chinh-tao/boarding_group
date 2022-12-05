import 'package:boarding_group/app/common/auth.dart';
import 'package:boarding_group/app/common/config.dart';
import 'package:boarding_group/app/common/global.dart';
import 'package:boarding_group/app/modules/user/controller/user_controller.dart';
import 'package:boarding_group/app/widget/button/primary_button.dart';
import 'package:boarding_group/app/widget/button/second_outlined_button.dart';
import 'package:boarding_group/app/widget/custom_input.dart';
import 'package:boarding_group/app/widget/image/custom_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../widget/image/custom_image_default.dart';

class UserView extends ConsumerStatefulWidget {
  const UserView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserViewState();
}

class _UserViewState extends ConsumerState<UserView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(userController.notifier).initData(ref);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                top: 30,
                left: 10,
                child: IconButton(
                    onPressed: () => navKey.currentState!.pop(),
                    icon: const Icon(Icons.arrow_back_ios,
                        color: kWhiteColor, size: 27)),
              ),
              Column(
                children: [
                  const SizedBox(height: 40),
                  Center(
                      child: Stack(
                    children: [
                      ref.watch(showImage),
                      Positioned(
                          left: 165,
                          top: 140,
                          child: GestureDetector(
                            onTap: () =>
                                ref.watch(userController).showModalSheet(ref),
                            child: Container(
                              padding: const EdgeInsets.all(7),
                              decoration: const BoxDecoration(
                                  color: kYellowColor800,
                                  shape: BoxShape.circle),
                              child: const Icon(Icons.image_rounded,
                                  color: kWhiteColor, size: 20),
                            ),
                          ))
                    ],
                  )),
                  const SizedBox(height: 30),
                  Container(
                    width: size.width,
                    height: ref.watch(_maxHeight),
                    decoration: BoxDecoration(
                        color: kWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 10,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 10),
                      child: Column(
                        children: [
                          CustomInput(
                              controller: ref.watch(userController).inputID,
                              title: 'Căn cước',
                              background: kBodyText.withOpacity(0.15),
                              readOnly: true,
                              err: ''),
                          const SizedBox(height: 10),
                          CustomInput(
                              controller: ref.watch(userController).inputName,
                              readOnly: true,
                              title: 'Họ và tên',
                              background: kBodyText.withOpacity(0.15),
                              err: ''),
                          const SizedBox(height: 10),
                          CustomInput(
                              controller: ref.watch(userController).inputEmail,
                              title: 'Tài khoản email',
                              err: ref.watch(userController).listErr[0]),
                          const SizedBox(height: 10),
                          CustomInput(
                              controller: ref.watch(userController).inputPhone,
                              title: 'Số điện thoại',
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              err: ref.watch(userController).listErr[1]),
                          const SizedBox(height: 10),
                          CustomInput(
                              controller: ref.watch(userController).inputRoom,
                              title: 'Phòng',
                              background: kBodyText.withOpacity(0.15),
                              readOnly: true,
                              err: ''),
                          const SizedBox(height: 30),
                          Wrap(
                            runSpacing: 7,
                            children: [
                              SecondOutlinedButton(
                                  height: 55,
                                  width: ref.watch(_maxWidth),
                                  title: 'Đổi mật khẩu',
                                  onPressed: () => ref
                                      .watch(userController)
                                      .showChangePass(),
                                  sizeText: 20,
                                  borderRadius: 30,
                                  color: kIndigoBlueColor900),
                              const SizedBox(width: 15),
                              PrimaryButton(
                                  isLoading:
                                      ref.watch(userController).isLoading,
                                  scale: 0.9,
                                  height: 55,
                                  width: ref.watch(_maxWidth),
                                  content: "Cập nhập",
                                  sizeContent: 20,
                                  colors: kIndigoBlueColor900,
                                  onPressed: () => ref
                                      .read(userController.notifier)
                                      .handleUpdateUser(ref))
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}

final _maxWidth = Provider<double>((ref) {
  if (size.width <= 372) {
    return size.width;
  }
  return size.width / 2.4;
});

final _maxHeight = Provider<double>((ref) {
  if (size.height <= 846) {
    return 630;
  }
  return size.height - 270;
});

final showImage = Provider.autoDispose<Widget>((ref) {
  if (ref.watch(userController).fileImage.path.isEmpty) {
    return CustomImage(
        width: 200,
        height: 200,
        url: ref.watch(Auth.user).getImages,
        errorWidget: const CustomImageDefault(
            iconSize: 150,
            height: 200,
            width: 200,
            backgroundColor: kGreyColor400));
  }
  return Container(
    height: 200,
    width: 200,
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: FileImage(ref.watch(userController).fileImage),
            fit: BoxFit.cover)),
  );
});
