import 'package:boarding_group/app/common/config.dart';
import 'package:boarding_group/app/common/global.dart';
import 'package:boarding_group/app/widget/button/button_loading.dart';
import 'package:boarding_group/app/widget/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../controllers/forgot_pass_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPassView extends ConsumerWidget {
  const ForgotPassView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: SizedBox(
          width: size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomInput(
                  title: '',
                  controller: ref.watch(forgotPassController).inputCode,
                  maxLength: 12,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  hintText: 'căn cước hoặc hộ chiếu',
                  err: ref.watch(forgotPassController).listError[0]),
              const SizedBox(height: 17),
              CustomInput(
                  title: '',
                  controller: ref.watch(forgotPassController).inputEmail,
                  hintText: 'tài khoản email',
                  err: ref.watch(forgotPassController).listError[1]),
              const SizedBox(height: 35),
              ButtonLoading(
                  height: 50,
                  width: 170,
                  sizeContent: 16,
                  colors: kIndigoBlueColor900,
                  isLoading: ref.watch(forgotPassController).isLoading,
                  titleButton: 'GỬI',
                  onPressed: () async =>
                      await ref.read(forgotPassController.notifier).submit())
            ],
          )),
    );
  }
}
