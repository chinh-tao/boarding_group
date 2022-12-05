import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../common/config.dart';
import '../../../common/global.dart';
import '../../../common/primary_style.dart';
import '../../bill/controller/bill_controller.dart';
import '../controller/notice_controller.dart';
import 'components/list_notice.dart';

class NoticeView extends ConsumerStatefulWidget {
  const NoticeView({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _NoticeViewState();
}

class _NoticeViewState extends ConsumerState<NoticeView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(noticeController.notifier).loadNotice();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final read = ref.read(noticeController.notifier);

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Text("Thông báo", style: PrimaryStyle.normal(20)),
          leading: IconButton(
              onPressed: () => navKey.currentState!.pop(),
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: RefreshIndicator(
            onRefresh: () async => read
                .loadNotice(isRefresh: true),
            backgroundColor: kPrimaryColor,
            color: kWhiteColor,
            child: ref.watch(showList)));
  }
}

final showList = Provider.autoDispose<Widget>((ref) {
  if (ref.watch(noticeController).isLoading) {
    return const Center(
      child: CircularProgressIndicator(color: kPrimaryColor),
    );
  } else {
    return const Expanded(child: ListNotice());
  }
});
