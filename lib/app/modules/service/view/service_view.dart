import 'package:boarding_group/app/common/config.dart';
import 'package:boarding_group/app/modules/service/controller/service_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/primary_style.dart';

class ServiceView extends ConsumerWidget {
  const ServiceView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 5),
          child: Text("Dịch vụ", style: PrimaryStyle.bold(20)),
        ),
        Expanded(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              shrinkWrap: true,
              itemCount: ref.watch(_controller).listService.length,
              itemBuilder: (BuildContext context, int index) {
                final listService = ref.watch(_controller).listService[index];
                return itemService(listService.icon!, listService.title!);
              }),
        ),
      ],
    );
  }
}

final _controller = ChangeNotifierProvider.autoDispose<ServiceController>(
    (ref) => ServiceController());

Widget itemService(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, size: 30, color: kIndigoBlueColor900),
          const SizedBox(height: 5),
          Text(text,
              style: PrimaryStyle.regular(12, color: kRedColor600),
              textAlign: TextAlign.center)
        ]),
      ),
    ),
  );
}
