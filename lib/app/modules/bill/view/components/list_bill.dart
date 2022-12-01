import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common/config.dart';
import '../../../../common/primary_style.dart';
import '../../../../routes/app_pages.dart';
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
    return ListView.builder(
        shrinkWrap: true,
        itemCount: ref.watch(billController).listBill.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final listBill = ref.watch(billController).listBill[index];
          final status = ref.watch(billController).status;
          final date = listBill.deadline!;

          return Card(
            elevation: 5,
            margin: const EdgeInsets.all(6),
            color: backgroundColor(ref, listBill.deadline!),
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
                            color: colorText(status, date) ??
                                kIndigoBlueColor900)),
                    ItemInvoice(
                        title: 'Phòng:',
                        content: '${listBill.roomNumber}',
                        color: colorText(status, date),
                        color2: colorText(status, date)),
                    ItemInvoice(
                        title: 'Ngày tạo:',
                        content: '${listBill.dateCreate}',
                        color: colorText(status, date),
                        color2: colorText(status, date)),
                    ItemInvoice(
                        title: 'Ngày hết hạn:',
                        content: '${listBill.deadline}',
                        color: colorText(status, date) ?? kRedColor600,
                        color2: colorText(status, date) ?? kRedColor600),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

Color? colorText(int status, String date) {
  if (status == 0) {
    return null;
  }
  return Colors.white;
}

Color? backgroundColor(WidgetRef ref, String date) {
  final status = ref.watch(billController).status;

  if (status == 1) {
    return kGreenColor700;
  } else {
    if (DateTime.parse(date).difference(DateTime.now()).inDays <= 0 ||
        status == 2) {
      ref.read(billController.notifier).status = 2;
      return kRedColor400;
    } else if (status == 3) {
      return kOrangeColor800;
    }
    return null;
  }
}
