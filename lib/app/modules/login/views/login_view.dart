import 'package:boarding_group/app/common/config.dart';
import 'package:boarding_group/app/common/primary_style.dart';
import 'package:boarding_group/app/widget/button/button_loading.dart';
import 'package:boarding_group/app/widget/button/second_text_button.dart';
import 'package:boarding_group/app/widget/custom_input.dart';
import 'package:boarding_group/app/widget/image/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widget/image/custom_image_default.dart';
import '../controllers/login_controller.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(_controller.notifier).initData(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 80),
              ref.watch(images),
              const SizedBox(height: 10),
              Text(ref.watch(title),
                  textAlign: TextAlign.center,
                  style: PrimaryStyle.bold(color: kPrimaryColor, 33)),
              const SizedBox(height: 40),
              if (ref.watch(_controller).arguments['category'] != '1') ...[
                CustomInput(
                  controller: ref.watch(_controller).inputEmail,
                  title: 'Tài khoản email',
                  err: ref.watch(_controller).listErrLogin[0],
                ),
                const SizedBox(height: 15),
              ],
              CustomInput(
                controller: ref.watch(_controller).inputPass,
                title: 'Mật khẩu',
                obscureText: ref.watch(_controller).isHidePass,
                icons: IconButton(
                    icon: Icon(ref.watch(icons), color: kPrimaryColor),
                    onPressed: () =>
                        ref.read(_controller.notifier).handleShowPass()),
                err: ref.watch(_controller).listErrLogin[1],
              ),
              const SizedBox(height: 40),
              ButtonLoading(
                  height: 55,
                  width: 170,
                  sizeContent: 18,
                  isLoading: ref.watch(_controller).isLoading,
                  titleButton: "Đăng nhập",
                  onPressed: () async =>
                      await ref.read(_controller.notifier).submit(ref)),
              const SizedBox(height: 22),
              if (ref.watch(_controller).arguments['category'] == '0') ...[
                Align(
                  alignment: Alignment.centerRight,
                  child: SecondTextButton(
                      onPressed: () =>
                          ref.read(_controller.notifier).showForgotPass(),
                      title: 'Quên mật khẩu?'),
                )
              ] else ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: SecondTextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      title: 'Đổi tài khoản',
                      iconLeft: Icons.arrow_back_ios),
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}

var _controller = ChangeNotifierProvider.autoDispose<LoginController>(
    (ref) => LoginController());

final title = Provider.autoDispose<String>((ref) {
  if (ref.watch(_controller).arguments['category'] == '1') {
    return ref.watch(_controller).userModel.userName!;
  }
  return 'Boarding Group';
});

final icons = Provider.autoDispose<IconData>((ref) {
  if (ref.watch(_controller).isHidePass) {
    return Icons.visibility_off_outlined;
  }
  return Icons.visibility_outlined;
});

final images = Provider.autoDispose<Widget>((ref) {
  if (ref.watch(_controller).arguments['category'] == '1') {
    return CustomImage(
        width: 200,
        height: 200,
        url: ref.watch(_controller).userModel.images!,
        errorWidget: CustomImageDefault(
            sizeText: 90,
            height: 200,
            width: 200,
            content: ref.watch(_controller).userModel.userName![0]));
  }
  return Image.asset('assets/images/logo.png', height: 200);
});
