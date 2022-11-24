import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/config.dart';
import '../../../../common/primary_style.dart';
import '../../controllers/list_account_controller.dart';

class CustomMenu extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (ref.watch(_controller).isHideMenu) ...[
          itemMenu(
              content: "Thêm tài khoản",
              icon: Icons.add,
              onPressed: () => ref.read(_controller.notifier).handleShowPage(),
              paddingWidth: 3,
              bottom: 70),
          itemMenu(
              content: "Quên mật khẩu",
              icon: Icons.pin_rounded,
              onPressed: () => ref.read(_controller.notifier).showForgotPass(),
              paddingWidth: 5,
              bottom: 120),
          itemMenu(
              bottom: 0,
              onPressed: () => ref.read(_controller.notifier).handleClose()),
        ] else ...[
          FloatingActionButton(
            backgroundColor: kOrangeColor800,
            onPressed: () => ref.read(_controller.notifier).handleOpen(),
            child: const Icon(Icons.menu, color: kWhiteColor, size: 27),
          )
        ],
      ],
    );
  }
}

final _controller = ChangeNotifierProvider<ListAccountController>(
    (ref) => ListAccountController());
