import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common/config.dart';
import '../../../../widget/image/custom_image.dart';
import '../../controller/bill_controller.dart';

class ShowImage extends ConsumerWidget {
  const ShowImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watch = ref.watch(billController);
    final read = ref.read(billController);
    final fileImage = watch.fileImage;

    return Padding(
        padding: const EdgeInsets.all(10),
        child: GestureDetector(
            onTap: watch.image.isEmpty ? () => read.showModalSheet(ref) : null,
            child: Container(
                height: 200,
                width: 130,
                decoration: BoxDecoration(
                    color: kBodyText, borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Image border
                  child: watch.image.isEmpty
                      ? (fileImage.path.isEmpty
                          ? const Icon(Icons.add_a_photo, color: Colors.white)
                          : Image.file(fileImage, fit: BoxFit.fill))
                      : CustomImage(
                          width: 80,
                          height: 80,
                          url: watch.image,
                          shape: BoxShape.rectangle,
                          errorWidget: const Icon(Icons.add_a_photo,
                              color: Colors.white)),
                ))));
  }
}
