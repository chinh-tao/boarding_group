import 'package:boarding_group/app/common/primary_style.dart';
import 'package:boarding_group/app/modules/login/controllers/list_account_controller.dart';
import 'package:boarding_group/app/widget/image/custom_image.dart';
import 'package:boarding_group/app/widget/image/custom_image_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/config.dart';
import '../../../../common/global.dart';

class BodyListAccount extends ConsumerWidget {
  const BodyListAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: SingleChildScrollView(
          child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Card(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: SingleChildScrollView(
            scrollDirection:
                size.width < 411.4 ? Axis.horizontal : Axis.vertical,
            child: Container(
              constraints: const BoxConstraints(maxHeight: 450),
              width: size.width < 411.4 ? size.width * 1.1 : size.width,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: ref.watch(listAccountController).listUser.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => ref
                          .read(listAccountController.notifier)
                          .showBottomSheet(index, ref),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: (index + 1) !=
                                        ref
                                            .watch(listAccountController)
                                            .listUser
                                            .length
                                    ? BorderSide(
                                        width: 2,
                                        color: kBodyText.withOpacity(0.3))
                                    : BorderSide.none)),
                        padding: const EdgeInsets.only(
                            left: 14, bottom: 10, top: 10),
                        child: Row(
                          children: [
                            CustomImage(
                                width: 80,
                                height: 80,
                                url: ref
                                    .watch(listAccountController)
                                    .listUser[index]
                                    .getImages,
                                errorWidget: const CustomImageDefault(
                                    backgroundColor: kGreyColor400)),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ref
                                      .watch(listAccountController)
                                      .listUser[index]
                                      .userName!,
                                  style: PrimaryStyle.bold(21),
                                ),
                                Text(
                                    ref
                                        .watch(listAccountController)
                                        .listUser[index]
                                        .email!,
                                    style: PrimaryStyle.regular(18))
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ),
      )),
    );
  }
}
