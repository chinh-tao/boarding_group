import 'package:boarding_group/app/common/global.dart';
import 'package:boarding_group/app/modules/bill/controller/bill_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../../common/config.dart';
import '../../../common/primary_style.dart';
import '../../../routes/app_pages.dart';
import '../controller/bill_controller.dart';

class ListBillView extends ConsumerStatefulWidget {
  const ListBillView({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _ListBillViewState();
}

class _ListBillViewState extends ConsumerState<ListBillView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(billController.notifier).initData(ref);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 5),
          child: Text('Hoá đơn', style: PrimaryStyle.bold(20)),
        ),
        Expanded(
            child: RefreshIndicator(
                onRefresh: () async =>
                    ref.read(billController.notifier).loadDataBill(ref),
                backgroundColor: kPrimaryColor,
                color: kWhiteColor,
                child: ref.watch(showList)))
      ],
    );
  }
}

final showList = Provider.autoDispose<Widget>((ref) {
  if (ref.watch(billController).isLoading) {
    return const Center(
      child: CircularProgressIndicator(color: kPrimaryColor),
    );
  } else if (ref.watch(billController).listBill.isEmpty) {
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
        return Card(
          elevation: 5,
          margin: const EdgeInsets.all(6),
          color: backgroundColor(
              ref.watch(billController).status, listBill.deadline!),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: InkWell(
            onTap: () => navKey.currentState!
                .pushNamed(Routes.DETAIL_BILL, arguments: index),
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Text('${listBill.nameBill}',
                      style: PrimaryStyle.normal(20,
                          color: colorText(ref.watch(billController).status,
                                  listBill.deadline!) ??
                              kIndigoBlueColor900)),
                  itemText('Phòng:', '${listBill.roomNumber}',
                      status: ref.watch(billController).status,
                      date: listBill.deadline!),
                  itemText('Ngày tạo:', '${listBill.dateCreate}',
                      status: ref.watch(billController).status,
                      date: listBill.deadline!),
                  itemText('Ngày hết hạn:', '${listBill.deadline}',
                      color: kRedColor600,
                      status: ref.watch(billController).status,
                      date: listBill.deadline!),
                ],
              ),
            ),
          ),
        );
      });
});

Widget itemText(
  String title,
  String content, {
  Color? color,
  int? status,
  String? date,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title,
          style: PrimaryStyle.medium(16,
              color: colorText(status!, date!) ?? kIndigoBlueColor900)),
      Text(content,
          style: PrimaryStyle.medium(16,
              color:
                  colorText(status, date) ?? (color ?? kIndigoBlueColor900))),
    ],
  );
}

Color? colorText(int status, String date) {
  if (status == 1 ||
      DateTime.parse(date).difference(DateTime.now()).inDays <= 0) {
    return Colors.white;
  }
  return null;
}

Color? backgroundColor(int status, String date) {
  if (status == 1) {
    return kGreenColor700;
  } else {
    if (DateTime.parse(date).difference(DateTime.now()).inDays <= 0) {
      return kRedColor400;
    }
    return null;
  }
}
