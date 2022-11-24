import 'package:boarding_group/app/common/config.dart';
import 'package:boarding_group/app/modules/register/controllers/register_controller.dart';
import 'package:boarding_group/app/widget/button/button_loading.dart';
import 'package:boarding_group/app/widget/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BodyRegister extends ConsumerWidget {
  const BodyRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 80),
            GestureDetector(
              onTap: () => ref.read(_controller.notifier).showModalSheet(),
              child: CircleAvatar(
                foregroundImage: ref.watch(_controller).fileImage.path != ''
                    ? Image.file(ref.watch(_controller).fileImage, height: 170)
                        .image
                    : null,
                radius: 110,
                backgroundColor: kGreyColor400,
                child: ref.watch(_controller).fileImage.path == ''
                    ? const Icon(Icons.add_a_photo,
                        color: Colors.black, size: 50)
                    : const SizedBox.shrink(),
              ),
            ),
            const SizedBox(height: 30),
            CustomInput(
              controller: ref.watch(_controller).inputCode,
              title: 'Căn cước/chứng minh thư',
              keyboardType: TextInputType.number,
              onChanged: (value) =>
                  ref.read(_controller.notifier).handleChangeInputName(value),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              err: ref.watch(_controller).listError[0],
            ),
            const SizedBox(height: 8),
            CustomInput(
              readOnly: true,
              controller: ref.watch(_controller).inputName,
              background: kGreyColor400,
              hintText: 'tên người dùng',
              title: '',
              err: '',
            ),
            const SizedBox(height: 15),
            CustomInput(
              controller: ref.watch(_controller).inputEmail,
              title: 'Tài khoản email',
              err: ref.watch(_controller).listError[1],
            ),
            const SizedBox(height: 40),
            ButtonLoading(
                height: 55,
                width: 170,
                sizeContent: 18,
                colors: kPrimaryColor,
                isLoading: ref.watch(_controller).isLoading,
                titleButton: "Đăng ký",
                onPressed: () => ref.read(_controller.notifier).submit(ref))
          ],
        ),
      ),
    );
  }
}

final _controller = ChangeNotifierProvider.autoDispose<RegisterController>(
    (ref) => RegisterController());
