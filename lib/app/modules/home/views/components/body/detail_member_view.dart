import 'package:boarding_group/app/common/global.dart';
import 'package:boarding_group/app/common/primary_style.dart';
import 'package:boarding_group/app/modules/home/controllers/home_controller.dart';
import 'package:boarding_group/app/widget/image/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common/config.dart';
import '../../../../../widget/image/custom_image_default.dart';

class DetailMemberView extends ConsumerWidget {
  const DetailMemberView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ModalRoute.of(context)!.settings.arguments as int;
    final member = ref.watch(homeController).listMember[index];

    return Scaffold(
        backgroundColor: kBlackColor900,
        body: Stack(
          children: [
            Positioned(
              top: 35,
              left: 7,
              child: IconButton(
                  onPressed: () => navKey.currentState!.pop(),
                  icon: const Icon(Icons.arrow_back_ios, color: kWhiteColor)),
            ),
            Center(
              child: SizedBox(
                  width: size.width,
                  height: size.height / 2,
                  child: Stack(
                    children: [
                      CustomImage(
                          width: double.infinity,
                          height: double.infinity,
                          shape: BoxShape.rectangle,
                          url: member.getImages,
                          errorWidget: CustomImageDefault(
                              width: size.width,
                              height: size.height / 2,
                              backgroundColor: kGreyColor400,
                              iconSize: 300,
                              shape: BoxShape.rectangle)),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: size.width,
                          color: kBlackColor900.withOpacity(0.5),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 13),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              item("Họ và tên:", member.getUserName),
                              const SizedBox(height: 3),
                              item("Tài khoản email:", member.getEmail),
                              const SizedBox(height: 3),
                              item("Điện thoại:", member.getPhone),
                              const SizedBox(height: 3),
                              item("Phòng:", member.getRoomNumber),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            )
          ],
        ));
  }

  Widget item(String title, String content) {
    return Row(
      children: [
        Text(title, style: PrimaryStyle.medium(19, color: kWhiteColor)),
        const SizedBox(width: 7),
        if (content.isEmpty) ...[
          Text("(chưa cập nhập)",
              style: PrimaryStyle.regular(17, color: kWhiteColor))
        ] else ...[
          Text(content, style: PrimaryStyle.regular(18, color: kWhiteColor))
        ]
      ],
    );
  }
}
