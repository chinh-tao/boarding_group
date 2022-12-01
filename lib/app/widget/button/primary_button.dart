import 'package:boarding_group/app/common/config.dart';
import 'package:boarding_group/app/common/primary_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrimaryButton extends ConsumerWidget {
  const PrimaryButton(
      {Key? key,
      required this.height,
      required this.width,
      required this.content,
      required this.onPressed,
      this.colors = kIndigoBlueColor900,
      this.sizeContent = 12,
      this.isLoading = false,
      this.scale = 0.8})
      : super(key: key);

  final Function()? onPressed;
  final Color? colors;
  final String content;
  final double sizeContent, height, width, scale;
  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: isLoading ? kGreyColor400 : colors,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30))),
          onPressed: onPressed,
          child: showContent),
    );
  }

  Widget get showContent {
    if (isLoading) {
      return Transform.scale(
          scale: scale,
          child: Center(child: CircularProgressIndicator(color: colors)));
    }
    return Text(
      content,
      style: PrimaryStyle.medium(sizeContent),
    );
  }
}
