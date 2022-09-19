import 'package:boarding_group/app/common/config.dart';
import 'package:boarding_group/app/common/primary_style.dart';
import 'package:flutter/material.dart';

class SecondOutlinedButton extends StatelessWidget {
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
      this.background})
      : super(key: key);

  final bool isLoading;
  final String title;
  final double sizeText, width, height, strokeWidth;
  final Color? color, background;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            fixedSize: Size(width, height),
            side: BorderSide(color: color!, width: 2),
            padding: const EdgeInsets.all(10),
            backgroundColor: background),
        onPressed: onPressed,
        child: showContent());
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
