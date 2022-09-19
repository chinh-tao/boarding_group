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
      this.sizeText = 35})
      : super(key: key);

  final String content;
  final double? height, width, sizeText;
  final Color? backgroundColor, textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: CircleAvatar(
        backgroundColor: backgroundColor,
        radius: 80,
        child: Text(content.toUpperCase(),
            style: PrimaryStyle.bold(sizeText!, color: textColor)),
      ),
    );
  }
}
