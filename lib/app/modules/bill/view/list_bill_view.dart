import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../../common/config.dart';
import '../../../common/primary_style.dart';
import '../controller/bill_controller.dart';
import 'components/list_bill.dart';

class ListBillView extends ConsumerStatefulWidget {
  const ListBillView({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _ListBillViewState();
}

class _ListBillViewState extends ConsumerState<ListBillView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(billController.notifier).initData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: RefreshIndicator(
                onRefresh: () async =>
                    ref.read(billController.notifier).loadDataBill(),
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
  } else {
    return const ListBill();
  }
});
