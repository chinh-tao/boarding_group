import 'package:boarding_group/app/common/global.dart';
import 'package:boarding_group/app/widget/button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common/config.dart';
import '../../../../../widget/custom_input.dart';
import '../../../controllers/home_controller.dart';

class SearchListMember extends ConsumerWidget {
  const SearchListMember({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomInput(
              title: 'Tìm kiếm theo tên',
              background: kWhiteColor,
              controller: ref.watch(homeController).inputName,
              err: ''),
          const SizedBox(height: 10),
          CustomInput(
              title: 'Tìm kiếm theo tên phòng',
              background: kWhiteColor,
              controller: ref.watch(homeController).inputRoom,
              err: ''),
          const SizedBox(height: 23),
          PrimaryButton(
              height: 50,
              width: double.infinity,
              content: "Tìm kiếm",
              sizeContent: 20,
              onPressed: () async {
                navKey.currentState!.pop();
                await ref.read(homeController.notifier).getListMember();
              })
        ],
      ),
    );
  }
}
