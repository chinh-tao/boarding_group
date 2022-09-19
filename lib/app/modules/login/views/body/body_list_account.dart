import 'package:boarding_group/app/common/primary_style.dart';
import 'package:boarding_group/app/modules/login/controllers/list_account_controller.dart';
import 'package:boarding_group/app/widget/image/custom_image_default.dart';
import 'package:boarding_group/app/widget/image/custom_image_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/config.dart';

class BodyListAccount extends StatelessWidget {
  const BodyListAccount({Key? key}) : super(key: key);

  BorderSide getBorder(List<int> index) {
    if (index[0] != index[1]) {
      return const BorderSide(width: 0.5, color: kBodyText);
    }
    return BorderSide.none;
  }

  double getPadding(List<int> index) {
    if (index[0] != index[1]) {
      return 10;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return GetX<ListAccountController>(builder: (_) {
      if (_.isLoading.value) {
        return const Center(
            child: Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(color: Colors.white)));
      }
      final listAccount = _.authController.listUser;
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
                  Get.size.width < 411.4 ? Axis.horizontal : Axis.vertical,
              child: Container(
                constraints: const BoxConstraints(maxHeight: 450),
                width: Get.size.width < 411.4 ? Get.width * 1.1 : Get.width,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: listAccount.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => _.showBottomSheet(listAccount[index]),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: getBorder(
                                      [index + 1, listAccount.length]))),
                          padding: EdgeInsets.only(
                              left: 10,
                              bottom:
                                  getPadding([index + 1, listAccount.length]),
                              top: getPadding([index, 0])),
                          child: Row(
                            children: [
                              if (listAccount[index].images == null) ...[
                                CustomImageDefault(
                                    content: listAccount[index].userName![0])
                              ],
                              if (listAccount[index].images != null) ...[
                                CachedNetworkImage(
                                  imageUrl: listAccount[index].images!,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: 80.0,
                                    height: 80.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      CustomImageLoading(
                                          animation: _.animation),
                                  errorWidget: (context, url, error) =>
                                      const CustomImageDefault(
                                          content: "null",
                                          backgroundColor: kRedColor400),
                                )
                              ],
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    listAccount[index].userName!,
                                    style: PrimaryStyle.bold(21),
                                  ),
                                  Text(listAccount[index].email!,
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
    });
  }
}
