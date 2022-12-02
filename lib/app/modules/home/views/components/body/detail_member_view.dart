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
          Center(
            child: CustomImage(
                width: size.width,
                height: size.height / 2,
                shape: BoxShape.rectangle,
                url: member.getImages,
                errorWidget: CustomImageDefault(
                    width: size.width,
                    height: size.height / 2,
                    backgroundColor: kGreyColor400,
                    iconSize: 300,
                    shape: BoxShape.rectangle)),
          ),
          Positioned(
            bottom: 210,
            child: Container(
              width: size.width,
              color: kBlackColor900.withOpacity(0.5),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Họ và tên: ${member.getUserName}",
                      style: PrimaryStyle.medium(18, color: kWhiteColor)),
                  const SizedBox(height: 3),
                  Text("Tài khoản email: ${member.getEmail}",
                      style: PrimaryStyle.medium(18, color: kWhiteColor)),
                  const SizedBox(height: 3),
                  Text("Điện thoại: ${member.getPhone}",
                      style: PrimaryStyle.medium(18, color: kWhiteColor)),
                  const SizedBox(height: 3),
                  Text("Phòng: ${member.getRoomNumber}",
                      style: PrimaryStyle.medium(18, color: kWhiteColor))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
