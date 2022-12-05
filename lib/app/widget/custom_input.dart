import 'package:boarding_group/app/common/config.dart';
import 'package:boarding_group/app/common/primary_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomInput extends ConsumerWidget {
  const CustomInput(
      {Key? key,
      required this.controller,
      required this.err,
      this.title = '',
      this.colorTitle = kBodyText,
      this.maxLength,
      this.maxLines = 1,
      this.inputFormatters,
      this.keyboardType,
      this.obscureText = false,
      this.onPressed,
      this.icons,
      this.readOnly = false,
      this.hintText = '',
      this.background,
      this.button,
      this.onTap,
      this.onChanged})
      : super(key: key);

  final TextEditingController controller;
  final String title, err, hintText;
  final Color? colorTitle, background;
  final int? maxLength, maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool obscureText, readOnly;
  final Widget? icons, button;
  final Function()? onPressed,onTap;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(left: 7),
            child:
                Text(title, style: PrimaryStyle.medium(17, color: colorTitle)),
          ),
          const SizedBox(height: 5)
        ],
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextField(
                controller: controller,
                style: PrimaryStyle.normal(color: kBodyText, 18),
                maxLength: maxLength,
                inputFormatters: inputFormatters,
                keyboardType: keyboardType ?? TextInputType.visiblePassword,
                obscureText: obscureText,
                readOnly: readOnly,
                onTap: onTap,
                onChanged: onChanged,
                maxLines: maxLines,
                decoration: InputDecoration(
                    fillColor: background,
                    filled: background != null ? true : false,
                    hintText: hintText,
                    hintStyle: PrimaryStyle.normal(
                        color: kBodyText.withOpacity(0.5), 17),
                    suffixIcon: icons,
                    counter: const SizedBox.shrink(),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 15, vertical: maxLines == 1 ? 0 : 15),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            width: 1, color: kBlackColor900.withOpacity(0.8))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: readOnly
                            ? BorderSide(
                                width: 1,
                                color: kBlackColor900.withOpacity(0.8))
                            : const BorderSide(
                                color: kPrimaryColor, width: 1.5))),
              ),
            ),
            if (button != null) ...[
              const SizedBox(width: 10),
              Expanded(flex: 1, child: button!)
            ]
          ],
        ),
        if (err.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child:
                Text(err, style: PrimaryStyle.normal(15, color: kRedColor400)),
          )
        ]
      ],
    );
  }
}
