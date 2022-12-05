import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common/config.dart';
import '../../../../common/global.dart';
import '../../../../common/primary_style.dart';
import '../../../../widget/item/item_invoice.dart';
import '../../controller/bill_controller.dart';

class ListBill extends ConsumerWidget {
  const ListBill({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(billController).listBill.isEmpty) {
      return Stack(
        children: [
          Center(
              child: Text('Không tìm thấy dữ liệu',
                  style: PrimaryStyle.bold(20, color: kRedColor400))),
          ListView(children: const []),
        ],
      );
    }
    return SizedBox(
      height: size.height,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: ref.watch(billController).listBill.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final listBill = ref.watch(billController).listBill[index];
            final status = ref.watch(billController).status;

            return Card(
              elevation: 5,
              margin: const EdgeInsets.all(6),
              color: backgroundColor(ref),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: InkWell(
                onTap: () => ref.watch(billController).nextDetail(index),
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text('${listBill.nameBill}',
                          style: PrimaryStyle.normal(20,
                              color: colorText(status) ??
                                  kIndigoBlueColor900)),
                      ItemInvoice(
                          title: 'Phòng:',
                          content: '${listBill.roomNumber}',
                          color: colorText(status),
                          color2: colorText(status)),
                      ItemInvoice(
                          title: 'Ngày tạo:',
                          content: '${listBill.dateCreate}',
                          color: colorText(status),
                          color2: colorText(status)),
                      ItemInvoice(
                          title: 'Ngày hết hạn:',
                          content: '${listBill.deadline}',
                          color: colorText(status) ?? kRedColor600,
                          color2: colorText(status) ?? kRedColor600),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

Color? colorText(int status) {
  if (status != 0 ) {
    return Colors.white;
  }
  return null;
}

Color? backgroundColor(WidgetRef ref) {
  final status = ref.watch(billController).status;

  if (status == 1) {
    return kGreenColor700;
  } else {
    if (status == 2) {
      ref.read(billController.notifier).status = 2;
      return kRedColor400;
    }
    return null;
  }
}
