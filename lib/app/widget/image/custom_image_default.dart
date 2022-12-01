import 'package:boarding_group/app/common/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomImageDefault extends ConsumerWidget {
  const CustomImageDefault(
      {Key? key,
      this.height = 80,
      this.width = 80,
      this.backgroundColor = kBlackColor900,
      this.shape,
      this.iconSize = 70})
      : super(key: key);

  final double? height, width, iconSize;
  final Color? backgroundColor;
  final BoxShape? shape;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: backgroundColor, shape: shape ?? BoxShape.circle),
      child: Icon(Icons.person, size: iconSize, color: kWhiteColor),
    );
  }
}
