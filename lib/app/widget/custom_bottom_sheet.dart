import 'package:boarding_group/app/common/config.dart';
import 'package:boarding_group/app/widget/item/item_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomBottomSheet extends ConsumerWidget {
  const CustomBottomSheet(
      {Key? key,
      required this.pickerImage,
      required this.imageCamera,
      this.removeAvatar})
      : super(key: key);

  final Function()? pickerImage, imageCamera, removeAvatar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        removeAvatar == null
            ? const SizedBox.shrink()
            : ItemBottomSheet(
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
