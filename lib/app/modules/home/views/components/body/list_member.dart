import 'package:boarding_group/app/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common/config.dart';
import '../../../../../common/primary_style.dart';
import '../../../../../widget/image/custom_image.dart';
import '../../../../../widget/image/custom_image_default.dart';

class ListMember extends ConsumerWidget {
  const ListMember({super.key, required this.listMember});

  final List<UserModel> listMember;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (listMember.isEmpty) {
      return Center(
        child: Text('Không tìm thấy dữ liệu',
            style: PrimaryStyle.bold(20, color: kRedColor400)),
      );
    }
    return ListView.builder(
        itemCount: listMember.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 10, top: index == 0 ? 15 : 0),
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
                        style: PrimaryStyle.bold(27)),
                    Text(listMember[index].getPhone,
                        style: PrimaryStyle.normal(18,
                            color: kBodyText.withOpacity(0.7)))
                  ],
                ))
              ],
            ),
          );
        });
  }
}
