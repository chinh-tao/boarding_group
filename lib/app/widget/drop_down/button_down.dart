import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/config.dart';
import '../../common/primary_style.dart';

class ButtonDown extends ConsumerWidget {
  const ButtonDown(
      {Key? key,
      required this.value,
      required this.list,
      this.color = kBodyText,
      this.iconSize,
      this.keyDropdown,
      this.onChanged})
      : super(key: key);

  final Key? keyDropdown;
  final String value;
  final List list;
  final Color color;
  final double? iconSize;
  final Function(dynamic)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButtonFormField2(
      key: keyDropdown,
      onChanged: onChanged,
      style: PrimaryStyle.normal(color: color, 18),
      isExpanded: true,
      iconSize: iconSize ?? 30,
      buttonHeight: 48,
      buttonPadding: EdgeInsets.zero,
      hint: Text(value),
      icon: const Padding(
          padding: EdgeInsets.only(right: 5),
          child: Icon(Icons.arrow_drop_down, color: Colors.black45)),
      dropdownDecoration:
          BoxDecoration(borderRadius: BorderRadius.circular(15)),
      items: list
          .map((item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: PrimaryStyle.normal(color: color, 18))))
          .toList(),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(width: 1, color: kBlackColor900.withOpacity(0.8))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: kPrimaryColor, width: 1.5))),
    );
  }
}
