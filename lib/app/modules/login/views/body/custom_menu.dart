import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/config.dart';
import '../../../../common/primary_style.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/list_account_controller.dart';

class CustomMenu extends StatelessWidget {
  const CustomMenu({Key? key}) : super(key: key);

  Widget itemMenu(
      {double? bottom,
      Function()? onPressed,
      IconData? icon,
      String? content,
      double? paddingWidth}) {
    return Positioned(
        right: 0,
        bottom: bottom,
        child: Row(
          children: [
            if (content != null) ...[
              Container(
                padding: EdgeInsets.zero,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: TextButton(
                  onPressed: onPressed,
                  child: Row(
                    children: [
                      Icon(icon, size: 20, color: Colors.white),
                      SizedBox(width: paddingWidth),
                      Text(content,
                          style: PrimaryStyle.normal(15, color: Colors.white))
                    ],
                  ),
                ),
              )
            ] else ...[
              FloatingActionButton(
                backgroundColor: kOrangeColor800,
                onPressed: onPressed,
                child: const Icon(Icons.close, color: kWhiteColor, size: 27),
              )
            ],
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GetX<ListAccountController>(builder: (_) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          if (_.isHideMenu.value) ...[
            itemMenu(
                content: "Thêm tài khoản",
                icon: Icons.add,
                onPressed: () {
                  _.isHideMenu(false);
                  Get.toNamed(Routes.LOGIN, parameters: {'category': '2'});
                },
                paddingWidth: 3,
                bottom: 70),
            itemMenu(
                content: "Quên mật khẩu",
                icon: Icons.pin_rounded,
                onPressed: () => _.showForgotPass(),
                paddingWidth: 5,
                bottom: 120),
            itemMenu(bottom: 0, onPressed: () => _.isHideMenu(false)),
          ] else ...[
            FloatingActionButton(
              backgroundColor: kOrangeColor800,
              onPressed: () => _.isHideMenu(true),
              child: const Icon(Icons.menu, color: kWhiteColor, size: 27),
            )
          ],
        ],
      );
    });
  }
}
