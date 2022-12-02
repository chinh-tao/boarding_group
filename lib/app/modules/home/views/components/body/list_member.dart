import 'package:boarding_group/app/common/global.dart';
import 'package:boarding_group/app/modules/home/controllers/home_controller.dart';
import 'package:boarding_group/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common/config.dart';
import '../../../../../common/primary_style.dart';
import '../../../../../widget/image/custom_image.dart';
import '../../../../../widget/image/custom_image_default.dart';

class ListMember extends ConsumerWidget {
  const ListMember({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listMember = ref.watch(homeController).listMember;

    return ListView.builder(
        itemCount: listMember.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => navKey.currentState!
                .pushNamed(Routes.DETAIL_MEMBER, arguments: index),
            child: Container(
              margin: EdgeInsets.only(bottom: 5, top: index == 0 ? 15 : 5),
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CustomImage(
                        width: 80,
                        height: 80,
                        url: listMember[index].getImages,
                        shape: BoxShape.rectangle,
                        errorWidget: const CustomImageDefault(
                            backgroundColor: kGreyColor400,
                            shape: BoxShape.rectangle)),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text(listMember[index].getUserName,
                          style: PrimaryStyle.bold(27),
                          overflow: TextOverflow.ellipsis),
                      Text('điện thoại: ${listMember[index].getPhone}',
                          style: PrimaryStyle.normal(18,
                              color: kBodyText.withOpacity(0.7))),
                      Text('phòng: ${listMember[index].getRoomNumber}',
                          style: PrimaryStyle.normal(18,
                              color: kBodyText.withOpacity(0.7)))
                    ],
                  ))
                ],
              ),
            ),
          );
        });
  }
}
