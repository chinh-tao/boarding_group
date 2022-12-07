import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/config.dart';
import '../../../widget/button/primary_button.dart';
import '../../../widget/custom_input.dart';
import '../controllers/register_controller.dart';

class RegisterView extends ConsumerWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 80),
              GestureDetector(
                onTap: () =>
                    ref.read(registerController.notifier).showModalSheet(),
                child: CircleAvatar(
                  foregroundImage:
                      ref.watch(registerController).fileImage.path != ''
                          ? Image.file(ref.watch(registerController).fileImage,
                                  height: 170)
                              .image
                          : null,
                  radius: 110,
                  backgroundColor: kGreyColor400,
                  child: ref.watch(registerController).fileImage.path == ''
                      ? const Icon(Icons.add_a_photo,
                          color: Colors.black, size: 50)
                      : const SizedBox.shrink(),
                ),
              ),
              const SizedBox(height: 30),
              CustomInput(
                controller: ref.watch(registerController).inputCode,
                title: 'Căn cước/chứng minh thư',
                keyboardType: TextInputType.number,
                onChanged: (value) => ref
                    .read(registerController.notifier)
                    .handleChangeInputName(value),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                err: ref.watch(registerController).listError[0],
              ),
              const SizedBox(height: 8),
              CustomInput(
                readOnly: true,
                controller: ref.watch(registerController).inputName,
                background: kGreyColor400,
                hintText: 'tên người dùng',
                title: '',
                err: '',
              ),
              const SizedBox(height: 15),
              CustomInput(
                controller: ref.watch(registerController).inputEmail,
                title: 'Tài khoản email',
                err: ref.watch(registerController).listError[1],
              ),
              const SizedBox(height: 40),
              PrimaryButton(
                  height: 55,
                  width: 170,
                  sizeContent: 18,
                  content: "Đăng ký",
                  colors: kPrimaryColor,
                  isLoading: ref.watch(registerController).isLoading,
                  onPressed: () =>
                      ref.read(registerController.notifier).submit())
            ],
          ),
        ),
      ),
    );
  }
}
