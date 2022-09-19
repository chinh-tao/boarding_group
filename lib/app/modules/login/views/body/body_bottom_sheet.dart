import 'package:boarding_group/app/common/config.dart';
import 'package:boarding_group/app/model/user_model.dart';
import 'package:boarding_group/app/routes/app_pages.dart';
import 'package:boarding_group/app/widget/item/item_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BodyBottomSheet extends StatelessWidget {
  const BodyBottomSheet(
      {Key? key,
      required this.removeAccount,
      required this.user,
      required this.changePass,
      this.isHideMenu = false})
      : super(key: key);

  final UserModel user;
  final Function()? removeAccount;
  final Function()? changePass;
  final bool isHideMenu;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 7),
        ItemBottomSheet(
            content: 'Đăng nhập',
            icon: Icons.privacy_tip,
            paddingVertical: 10,
            onTap: () {
              Get.back();
              Get.toNamed(Routes.LOGIN,
                  parameters: {'category': '1'}, arguments: {'user': user});
            }),
        ItemBottomSheet(
            content: 'Quên mật khẩu',
            icon: Icons.pin_rounded,
            onTap: changePass,
            paddingVertical: 7),
        if (!isHideMenu) ...[
          ItemBottomSheet(
              content: 'Xoá tài khoản trên thiết bị này',
              icon: Icons.highlight_remove,
              textColor: kRedColor400,
              iconColor: kRedColor400,
              paddingVertical: 7,
              onTap: removeAccount)
        ]
      ],
    );
  }
}
