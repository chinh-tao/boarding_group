import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/config.dart';
import '../../common/primary_style.dart';
import 'button_down.dart';

class ButtonDownForm extends ConsumerWidget {
  const ButtonDownForm(
      {Key? key,
      required this.title,
      required this.value,
      required this.list,
      this.color = kBodyText,
      this.iconSize,
      this.keyDropdown,
      this.onChanged})
      : super(key: key);

  final Key? keyDropdown;
  final String title, value;
  final List list;
  final Color color;
  final double? iconSize;
  final Function(dynamic)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: PrimaryStyle.medium(17, color: color)),
        const SizedBox(height: 5),
        ButtonDown(
          keyDropdown: keyDropdown,
            value: value, list: list, onChanged: onChanged, iconSize: iconSize)
      ],
    );
  }
}
