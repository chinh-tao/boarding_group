import 'package:boarding_group/app/common/primary_style.dart';
import 'package:boarding_group/app/widget/image/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../common/auth.dart';
import '../../../../../common/config.dart';
import '../../../../../common/global.dart';
import '../../../../../routes/app_pages.dart';
import '../../../controller/root_controller.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({super.key, required this.controller});

  final ChangeNotifierProvider<RootController> controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 180,
              width: double.infinity,
              color: kGreyColor400,
              child: Stack(children: [
                CustomImage(
                    width: size.width,
                    height: 180,
                    url: ref.watch(Auth.user).getImages,
                    shape: BoxShape.rectangle,
                    errorWidget: const Center(
                        child:
                            Icon(Icons.person, size: 180, color: kWhiteColor))),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: InkWell(
                    onTap: () {
                      Scaffold.of(context).closeDrawer();
                      navKey.currentState!.pushNamed(Routes.USER);
                    },
                    child: Container(
                      width: 304,
                      padding: const EdgeInsets.only(
                          left: 10, top: 5, bottom: 5, right: 3),
                      color: kBlackColor900.withOpacity(0.7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(ref.watch(Auth.user).getUserName,
                                  style: PrimaryStyle.bold(25,
                                      color: kWhiteColor)),
                              const SizedBox(height: 3),
                              Text('id: ${ref.watch(Auth.user).getID}',
                                  style: PrimaryStyle.regular(17,
                                      color: kWhiteColor))
                            ],
                          ),
                          const Icon(Icons.arrow_forward_ios,
                              color: kWhiteColor)
                        ],
                      ),
                    ),
                  ),
                )
              ]),
            ),
            ListView(shrinkWrap: true, children: [
              itemMenu(
                  Icons.checklist_outlined, 'Danh sách thành viên', ref, 0),
              itemMenu(Icons.assignment_outlined, 'Hoá đơn', ref, 1),
              itemMenu(Icons.assignment_late_outlined, 'Sự cố', ref, 2),
              itemMenu(Icons.bookmark_outline_outlined, 'Dịch vụ', ref, 3)
            ]),
          ],
        ),
      ),
    );
  }

  Widget itemMenu(IconData icons, String title, WidgetRef ref, int index) {
    return ListTile(
      onTap: () => ref.read(controller.notifier).handleChangeIndex(index),
      tileColor: ref.watch(controller).isSelected[index]
          ? kGreenColor700.withOpacity(0.3)
          : null,
      leading: Icon(icons, color: kIndigoBlueColor900, size: 30),
      title: Text(title,
          style: PrimaryStyle.normal(20, color: kIndigoBlueColor900)),
    );
  }
}
