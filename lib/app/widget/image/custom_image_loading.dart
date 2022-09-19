import 'package:boarding_group/app/common/config.dart';
import 'package:boarding_group/app/common/primary_style.dart';
import 'package:flutter/material.dart';

class CustomImageLoading extends StatelessWidget {
  const CustomImageLoading(
      {Key? key,
      required this.animation,
      this.width = 80,
      this.height = 80,
      this.sizeText = 20})
      : super(key: key);

  final Animation<double> animation;
  final double width, height, sizeText;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SizedBox(
        width: width,
        height: height,
        child: CircleAvatar(
            backgroundColor: kGreyColor400,
            radius: 80,
            child: Text("Zzz...",
                style: PrimaryStyle.normal(sizeText, color: Colors.white))),
      ),
    );
  }
}
