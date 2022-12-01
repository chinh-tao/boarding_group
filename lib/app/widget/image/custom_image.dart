import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../common/config.dart';

class CustomImage extends ConsumerWidget {
  const CustomImage(
      {super.key,
      required this.width,
      required this.height,
      required this.url,
      required this.errorWidget,
      this.shape});

  final double width, height;
  final String url;
  final BoxShape? shape;
  final Widget errorWidget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: shape ?? BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        );
      },
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: kBlackColor900.withOpacity(0.7),
            shape: shape ?? BoxShape.circle),
        child: const SpinKitFadingCircle(color: kWhiteColor, size: 42),
      ),
      errorWidget: (context, url, error) => errorWidget,
    );
  }
}
