import 'package:boarding_group/app/common/config.dart';
import 'package:boarding_group/app/common/primary_style.dart';
import 'package:flutter/material.dart';

class CustomImageDefault extends StatelessWidget {
  const CustomImageDefault(
      {Key? key,
      required this.content,
      this.height = 80,
      this.width = 80,
      this.backgroundColor = kBlackColor900,
      this.textColor = kWhiteColor,
      this.sizeText = 35,
      this.shape})
      : super(key: key);

  final String content;
  final double? height, width, sizeText;
  final Color? backgroundColor, textColor;
  final BoxShape? shape;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: backgroundColor, shape: shape ?? BoxShape.circle),
      child: const Icon(Icons.person, size: 70, color: kWhiteColor),
    );
  }
}
