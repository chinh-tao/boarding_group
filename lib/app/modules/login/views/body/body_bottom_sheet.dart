import 'package:boarding_group/app/common/config.dart';
import 'package:boarding_group/app/common/global.dart';
import 'package:boarding_group/app/model/user_model.dart';
import 'package:boarding_group/app/routes/app_pages.dart';
import 'package:boarding_group/app/widget/item/item_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BodyBottomSheet extends ConsumerWidget {
  const BodyBottomSheet(
      {Key? key, required this.removeAccount, required this.user})
      : super(key: key);

  final UserModel user;
  final Function()? removeAccount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const SizedBox(height: 7),
        ItemBottomSheet(
            content: 'Đăng nhập',
            icon: Icons.privacy_tip,
            paddingVertical: 10,
            onTap: () {
              navKey.currentState!.pop();
              navKey.currentState!.pushNamed(Routes.LOGIN,
                  arguments: {'category': '1', 'user': user});
            }),
        ItemBottomSheet(
            content: 'Xoá tài khoản trên thiết bị này',
            icon: Icons.highlight_remove,
            textColor: kRedColor400,
            iconColor: kRedColor400,
            paddingVertical: 7,
            onTap: removeAccount)
      ],
    );
  }
}
