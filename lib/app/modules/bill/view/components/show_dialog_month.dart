import 'package:boarding_group/app/modules/bill/controller/bill_controller.dart';
import 'package:boarding_group/app/widget/button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/config.dart';
import '../../../../common/global.dart';
import '../../../../common/primary_style.dart';

class ShowDialogMonth extends ConsumerWidget {
  const ShowDialogMonth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => ref.watch(billController).showMonth(),
            child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: kBlackColor900.withOpacity(0.8))),
                child: Text(ref.watch(billController).date,
                    style:
                        PrimaryStyle.medium(17, color: kIndigoBlueColor900))),
          ),
          const SizedBox(height: 30),
          PrimaryButton(
              isLoading: false,
              content: "Tìm kiếm",
              height: 50,
              width: double.infinity,
              sizeContent: 20,
              onPressed: () async {
                navKey.currentState!.pop();
                await ref.read(billController.notifier).loadDataBill(ref);
              })
        ],
      ),
    );
  }
}
