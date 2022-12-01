import 'package:flutter/material.dart';
import '../../common/config.dart';
import '../../common/primary_style.dart';

class ItemInvoice extends StatelessWidget {
  const ItemInvoice(
      {Key? key,
      required this.title,
      required this.content,
      this.color,
      this.color2,
      this.vertical = 1})
      : super(key: key);

  final String title, content;
  final Color? color, color2;
  final double vertical;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vertical),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:
                  PrimaryStyle.medium(16, color: color ?? kIndigoBlueColor900)),
          Text(content,
              style:
                  PrimaryStyle.medium(16, color: color2 ?? kIndigoBlueColor900))
        ],
      ),
    );
  }
}
