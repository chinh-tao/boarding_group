import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/config.dart';
import '../../common/primary_style.dart';

class ItemMenu extends ConsumerWidget {
  const ItemMenu(
      {super.key,
      required this.onPressed,
      this.icons,
      this.content,
      this.paddingWidth,
      this.backgroundMenu});

  final Function()? onPressed;
  final IconData? icons;
  final String? content;
  final double? paddingWidth;
  final Color? backgroundMenu;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        if (content != null) ...[
          Container(
            padding: EdgeInsets.zero,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: TextButton(
              onPressed: onPressed,
              child: Row(
                children: [
                  Icon(icons, size: 20, color: Colors.white),
                  SizedBox(width: paddingWidth),
                  Text(content!,
                      style: PrimaryStyle.normal(15, color: Colors.white))
                ],
              ),
            ),
          )
        ] else ...[
          FloatingActionButton(
            backgroundColor: backgroundMenu,
            onPressed: onPressed,
            child: const Icon(Icons.close, color: kWhiteColor, size: 27),
          )
        ],
      ],
    );
  }
}
