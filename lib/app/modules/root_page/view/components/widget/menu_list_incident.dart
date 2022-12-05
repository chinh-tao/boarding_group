import 'package:boarding_group/app/modules/root_page/controller/root_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../../../common/config.dart';
import '../../../../../common/global.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../widget/item/item_menu.dart';

class MenuListIncident extends ConsumerWidget {
  const MenuListIncident({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (ref.watch(rootController).isHideMenu) ...[
          Positioned(
              right: 0,
              bottom: 70,
              child: ItemMenu(
                  content: "Báo cáo sự cố",
                  icons: Icons.add,
                  onPressed: () => ref.read(rootController.notifier).showPage(),
                  paddingWidth: 3)),
          Positioned(
              right: 0,
              bottom: 120,
              child: ItemMenu(
                  content: "Lọc danh sách",
                  icons: Icons.filter_list_alt,
                  onPressed: () =>
                      ref.read(rootController.notifier).showFormSearch(),
                  paddingWidth: 5)),
          Positioned(
              right: 0,
              bottom: 0,
              child: ItemMenu(
                  backgroundMenu: kPrimaryColor,
                  onPressed: () =>
                      ref.read(rootController.notifier).handleShowMenu())),
        ] else ...[
          FloatingActionButton(
            backgroundColor: kPrimaryColor,
            onPressed: () => ref.read(rootController.notifier).handleShowMenu(),
            child: const Icon(Icons.menu, color: kWhiteColor, size: 27),
          )
        ],
      ],
    );
  }
}
