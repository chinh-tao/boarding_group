import 'package:boarding_group/app/modules/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/config.dart';
import '../../../../common/primary_style.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({Key? key, required this.controller}) : super(key: key);

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Transform.scale(
            scale: 0.9,
            child: Obx(() => Checkbox(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                activeColor: kPrimaryColor,
                value: false,
                onChanged: (value) {})),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14),
            child: Text.rich(TextSpan(
                text: '\tLưu tài khoản\n',
                style: PrimaryStyle.medium(15),
                children: [
                  TextSpan(
                      text: '(đăng nhập bằng một lần nhấn)',
                      style: PrimaryStyle.regular(14))
                ])),
          ),
        ],
      ),
    );
  }
}
