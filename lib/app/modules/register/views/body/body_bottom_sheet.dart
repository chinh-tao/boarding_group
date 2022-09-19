import 'package:boarding_group/app/common/config.dart';
import 'package:boarding_group/app/widget/item/item_bottom_sheet.dart';
import 'package:flutter/material.dart';

class BodyBottomSheet extends StatelessWidget {
  const BodyBottomSheet(
      {Key? key,
      required this.pickerImage,
      required this.imageCamera,
      required this.removeAvatar})
      : super(key: key);

  final Function()? pickerImage;
  final Function()? imageCamera;
  final Function()? removeAvatar;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 7),
        ItemBottomSheet(
            paddingVertical: 10,
            content: 'Chọn ảnh',
            icon: Icons.insert_photo,
            onTap: pickerImage),
        ItemBottomSheet(
            content: 'Chụp ảnh',
            icon: Icons.enhance_photo_translate,
            onTap: imageCamera,
            paddingVertical: 7),
        ItemBottomSheet(
            content: 'Xoá avatar',
            textColor: kRedColor400,
            icon: Icons.highlight_remove,
            iconColor: kRedColor400,
            onTap: removeAvatar,
            paddingVertical: 7),
      ],
    );
  }
}
