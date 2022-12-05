import 'package:boarding_group/app/modules/notification/controller/notice_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common/config.dart';
import '../../../../common/global.dart';
import '../../../../common/primary_style.dart';

class ListNotice extends ConsumerWidget {
  const ListNotice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watch = ref.watch(noticeController);
    if (watch.listNotice.reversed.isEmpty) {
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
          itemCount: watch.listNotice.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final listNotice = watch.listNotice[index];
            return itemNotice(
                date: '${listNotice.date}',
                title: '${listNotice.title}',
                content: '${listNotice.content}');
          }),
    );
  }
}

Widget itemNotice(
    {required String date, required String title, required String content}) {
  return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.notifications_sharp,
                    size: 20, color: kPrimaryColor),
                const SizedBox(width: 5),
                Text(date,
                    style: PrimaryStyle.normal(14, color: kPrimaryColor)),
              ],
            ),
            const SizedBox(width: 5),
            Text(title, style: PrimaryStyle.medium(16, color: kPrimaryColor)),
            const SizedBox(height: 5),
            Text(content, style: PrimaryStyle.regular(14)),
          ],
        ),
      ));
}
