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
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 220,
              width: double.infinity,
              color: kGreyColor400,
              child: Stack(children: [
                CustomImage(
                    width: size.width,
                    height: 220,
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
                      ref
                          .watch(rootController)
                          .rootKey
                          .currentState!
                          .closeDrawer();
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
            options(Icons.checklist_outlined, 'Danh sách thành viên', ref, 0),
            options(Icons.assignment_outlined, 'Hoá đơn', ref, 1),
            options(Icons.assignment_late_outlined, 'Sự cố', ref, 2),
            options(Icons.bookmark_outline_outlined, 'Dịch vụ', ref, 3),
            options(Icons.info_outlined, 'Thông tin', ref, 4),
            options(Icons.logout_outlined, 'Đăng xuất', ref, 5)
          ],
        ),
      ),
    );
  }

  Widget options(IconData icons, String title, WidgetRef ref, int index) {
    return ListTile(
      onTap: () =>
          ref.read(rootController.notifier).handleChangeIndex(index, ref),
      tileColor: ref.watch(background(index)),
      leading: Icon(icons, color: ref.watch(colors(index)), size: 30),
      title: Text(title,
          style: PrimaryStyle.bold(20, color: ref.watch(colors(index)))),
    );
  }
}

final background = Provider.autoDispose.family<Color?, int>((ref, index) {
  if (ref.watch(rootController).isSelected[index]) {
    return kGreenColor700.withOpacity(0.3);
  }
  return null;
});

final colors = Provider.autoDispose.family<Color?, int>((ref, index) {
  if (ref.watch(rootController).isSelected[index]) {
    return kIndigoBlueColor900;
  }
  return kBodyText;
});
