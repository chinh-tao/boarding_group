import 'package:boarding_group/app/common/config.dart';
import 'package:boarding_group/app/common/primary_style.dart';
import 'package:boarding_group/app/widget/custom_input.dart';
import 'package:flutter/material.dart';

class ChangePassView extends StatelessWidget {
  const ChangePassView(
      {Key? key,
      required this.controller,
      required this.textError,
      required this.submit,
      required this.isLoading})
      : super(key: key);

  final List<TextEditingController> controller;
  final List<String> textError;
  final Function() submit;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomInput(
              title: 'Mật khẩu mới',
              controller: controller[0],
              err: textError[0]),
          const SizedBox(height: 17),
          CustomInput(
              title: 'Xác nhận mật khẩu',
              controller: controller[1],
              err: textError[1]),
          const SizedBox(height: 25),
          if (isLoading) ...[
            const CircularProgressIndicator(color: kPrimaryColor)
          ],
          if (!isLoading) ...[
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 40), primary: kPrimaryColor),
                onPressed: submit,
                child: Text('Gửi yêu cầu',
                    style: PrimaryStyle.medium(18, color: kWhiteColor)))
          ],
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
