import 'package:boarding_group/app/widget/item/item_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/config.dart';
import '../../controllers/list_account_controller.dart';

class MenuListAccount extends ConsumerWidget {
  const MenuListAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (ref.watch(listAccountController).isHideMenu) ...[
          Positioned(
              right: 0,
              bottom: 70,
              child: ItemMenu(
                  content: "Thêm tài khoản",
                  icons: Icons.add,
                  onPressed: () =>
                      ref.read(listAccountController.notifier).handleShowPage(),
                  paddingWidth: 3)),
          Positioned(
              right: 0,
              bottom: 120,
              child: ItemMenu(
                  content: "Quên mật khẩu",
                  icons: Icons.pin_rounded,
                  onPressed: () =>
                      ref.read(listAccountController.notifier).showForgotPass(),
                  paddingWidth: 5)),
          Positioned(
              right: 0,
              bottom: 0,
              child: ItemMenu(
                  backgroundMenu: kOrangeColor800,
                  onPressed: () => ref
                      .read(listAccountController.notifier)
                      .handleShowMenu())),
        ] else ...[
          FloatingActionButton(
            backgroundColor: kOrangeColor800,
            onPressed: () =>
                ref.read(listAccountController.notifier).handleShowMenu(),
            child: const Icon(Icons.menu, color: kWhiteColor, size: 27),
          )
        ],
      ],
    );
  }
}
