import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/config.dart';
import '../button/button_loading.dart';
import '../custom_input.dart';

class ForgotPass extends StatelessWidget {
  ForgotPass(
      {Key? key,
      required this.textController,
      required this.isLoading,
      required this.onPressed,
      this.error = ''})
      : super(key: key);

  final TextEditingController textController;
  final bool isLoading;
  Function()? onPressed;
  final String error;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomInput(
              title: '',
              controller: textController,
              maxLength: 6,
              keyboardType: TextInputType.number,
              hintText: 'tài khoản email',
              err: error),
          const SizedBox(height: 35),
          ButtonLoading(
              height: 50,
              width: 170,
              sizeContent: 16,
              colors: kIndigoBlueColor900,
              isLoading: isLoading,
              titleButton: 'GỬI',
              onPressed: onPressed)
        ],
      ),
    );
  }
}
