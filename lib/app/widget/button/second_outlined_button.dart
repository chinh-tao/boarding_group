import 'package:boarding_group/app/common/config.dart';
import 'package:boarding_group/app/common/primary_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecondOutlinedButton extends ConsumerWidget {
  const SecondOutlinedButton(
      {Key? key,
      required this.title,
      required this.onPressed,
      this.isLoading = false,
      this.color = kPrimaryColor,
      this.sizeText = 18,
      this.width = 70,
      this.height = 50,
      this.strokeWidth = 4.0,
      this.background,
      this.borderRadius = 10})
      : super(key: key);

  final bool isLoading;
  final String title;
  final double sizeText, width, height, strokeWidth, borderRadius;
  final Color? color, background;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius)),
              side: BorderSide(color: color!, width: 2),
              padding: const EdgeInsets.all(10),
              backgroundColor: background),
          onPressed: onPressed,
          child: showContent()),
    );
  }

  Widget showContent() {
    if (isLoading) {
      return Center(
          child: SizedBox(
              width: height / 2,
              height: height / 2,
              child: CircularProgressIndicator(
                  color: color, strokeWidth: strokeWidth)));
    }
    return Text(title, style: PrimaryStyle.bold(sizeText, color: color));
  }
}
