import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/config.dart';
import '../../common/primary_style.dart';

class SecondTextButton extends ConsumerWidget {
  const SecondTextButton(
      {Key? key,
      required this.onPressed,
      required this.title,
      this.iconLeft,
      this.iconRight})
      : super(key: key);

  final Function()? onPressed;
  final IconData? iconLeft, iconRight;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FittedBox(
      fit: BoxFit.fill,
      child: TextButton(
          onPressed: onPressed,
          child: Row(
            children: [
              if (iconLeft != null) ...[
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Icon(iconLeft, color: kPrimaryColor, size: 18),
                )
              ],
              Text(title, style: PrimaryStyle.normal(18, color: kPrimaryColor)),
              if (iconRight != null) ...[
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Icon(iconRight, color: kPrimaryColor, size: 18),
                )
              ],
            ],
          )),
    );
  }
}
