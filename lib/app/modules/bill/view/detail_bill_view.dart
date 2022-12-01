import 'package:boarding_group/app/common/utils.dart';
import 'package:boarding_group/app/modules/bill/view/components/show_image.dart';
import 'package:boarding_group/app/widget/button/primary_button.dart';
import 'package:boarding_group/app/widget/drop_down/button_down_form.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../../common/config.dart';
import '../../../common/global.dart';
import '../../../common/primary_style.dart';
import '../../../widget/item/item_invoice.dart';
import '../controller/bill_controller.dart';

class DetailBillView extends ConsumerWidget {
  const DetailBillView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watch = ref.watch(billController.notifier);
    final index =
        int.parse(ModalRoute.of(context)!.settings.arguments.toString());
    final listBill = watch.listBill[index];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text("Chi tiết hóa đơn", style: PrimaryStyle.normal(20)),
        leading: IconButton(
            onPressed: () => navKey.currentState!.pop(),
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('${listBill.nameBill}',
                  style: PrimaryStyle.normal(20, color: kIndigoBlueColor900)),
              itemCard(
                child: Column(
                  children: [
                    ItemInvoice(
                        title: 'Trạng thái:',
                        content: showStatus(watch.status),
                        color2: colorText(watch.status),
                        vertical: 2),
                    ItemInvoice(
                        title: 'Phòng:',
                        content: '${listBill.roomNumber}',
                        vertical: 2),
                    ItemInvoice(
                        title: 'Ngày tạo:',
                        content: '${listBill.dateCreate}',
                        vertical: 2),
                    ItemInvoice(
                        title: 'Ngày hết hạn:',
                        content: '${listBill.deadline}',
                        color2: watch.status == 1 ? null : kRedColor600,
                        vertical: 2)
                  ],
                ),
              ),
              const SizedBox(height: 5),
              itemCard(
                child: Column(
                  children: [
                    ItemInvoice(
                        title: 'Tiền phòng:',
                        content: '${listBill.bill!.getRoom}đ',
                        vertical: 2),
                    ItemInvoice(
                        title: 'Tiền điện:',
                        content: '${listBill.bill!.getElectric}đ',
                        vertical: 2),
                    ItemInvoice(
                        title: 'Số điện:',
                        content: '${listBill.electricNumber} kwh',
                        vertical: 2),
                    ItemInvoice(
                        title: 'Tiền điện nước:',
                        content: '${listBill.bill!.getWater}đ',
                        vertical: 2),
                    ItemInvoice(
                        title: 'Wifi:',
                        content: '${listBill.bill!.getNetwork}đ',
                        vertical: 2),
                    ItemInvoice(
                        title: 'Tiền dịch vụ chung:',
                        content: '${listBill.bill!.getGeneral}đ',
                        vertical: 2),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              itemCard(
                child: Column(
                  children: [
                    ItemInvoice(
                        title: 'Tổng:',
                        vertical: 2,
                        content:
                            '${Utils.formatNumber('${listBill.bill!.sum}')}đ'),
                    ItemInvoice(
                        title: 'Số tiền phải thanh toán:',
                        vertical: 2,
                        content:
                            '${money(watch.memberNumber, listBill.bill!.sum)}đ'),
                    const Divider(thickness: 1),
                    ButtonDownForm(
                        title: "Phương thức thanh toán",
                        value: watch.category,
                        list: watch.categoryList,
                        color: kIndigoBlueColor900,
                        iconSize: watch.status == 0 ? null : 0,
                        onChanged: watch.status == 0
                            ? (value) => watch.billOnChanged(value)
                            : null),
                    ref.watch(showPayment),
                    ref.watch(showButtonPayment)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final showPayment = Provider<Widget>((ref) {
  final watch = ref.watch(billController);
  if (watch.category == "Tiền mặt" || watch.status == 3) {
    return const SizedBox.shrink();
  } else {
    return const ShowImage();
  }
});

final showButtonPayment = Provider<Widget>((ref) {
  if (ref.watch(billController).status != 0) {
    return const SizedBox.shrink();
  } else {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: PrimaryButton(
          height: 50,
          width: size.width,
          sizeContent: 18,
          isLoading: ref.watch(billController).isLoadingButton,
          content: "Thanh toán",
          onPressed: () => ref.read(billController).submitPayment()),
    );
  }
});

Widget itemCard({required Widget child}) {
  return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
          child: child));
}

String money(int memberNumber, int moneys) {
  var num = '${(moneys ~/ memberNumber)}';
  return Utils.formatNumber(num);
}

String showStatus(int status) {
  if (status == 1) {
    return 'Đã thanh toán';
  } else if (status == 2) {
    return 'Đã quá hạn';
  } else if (status == 3) {
    return 'Đang xử lý';
  }
  return 'Chưa thanh toán';
}

Color? colorText(int status) {
  if (status == 1) {
    return kGreenColor700;
  } else if (status == 2) {
    return kRedColor600;
  } else if (status == 3) {
    return kOrangeColor800;
  }
  return null;
}
