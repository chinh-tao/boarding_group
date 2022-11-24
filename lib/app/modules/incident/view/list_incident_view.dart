import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../common/config.dart';
import '../../../common/primary_style.dart';
import '../controller/list_incident_controller.dart';

// class ListIncidentView extends ConsumerWidget {
//   const ListIncidentView({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Container();
//   }
// }

class ListIncidentView extends ConsumerStatefulWidget {
  const ListIncidentView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListIncidentState();
}

class _ListIncidentState extends ConsumerState<ListIncidentView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(_controller.notifier).initData(ref);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text('Danh sách sự cố', style: PrimaryStyle.normal(20)),
        ),
        Expanded(
            child: RefreshIndicator(
                onRefresh: () async => ref
                    .read(_controller.notifier)
                    .initData(ref, isRefresh: true),
                backgroundColor: kIndigoBlueColor900,
                color: kWhiteColor,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: ref.watch(showListMember))))
      ],
    );
  }
}

final _controller = ChangeNotifierProvider.autoDispose<ListIncidentController>(
    (ref) => ListIncidentController());

final showListMember = Provider.autoDispose<Widget>((ref) {
  if (ref.watch(_controller).isLoading) {
    return const Center(
      child: CircularProgressIndicator(color: kIndigoBlueColor900),
    );
  } else if (ref.watch(_controller).lisIncident.isEmpty) {
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
      itemCount: ref.watch(_controller).lisIncident.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        final listIncident = ref.watch(_controller).lisIncident[index];
        return Card(
          elevation: 5,
          color: listIncident.status == 1 ? kGreenColor700 : null,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    itemText('Tên sự cố:', " ${listIncident.title}",
                        listIncident.status!),
                    const SizedBox(height: 5),
                    itemText('Người thông báo:', " ${listIncident.userName}",
                        listIncident.status!),
                    const SizedBox(height: 5),
                    itemText('Ngày thông báo:', " ${listIncident.date}",
                        listIncident.status!)
                  ],
                ),
                showLevel("${listIncident.level}")
              ],
            ),
          ),
        );
      });
});

Widget showLevel(String level) {
  if (level == "Cao") {
    return Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: kRedColor600, borderRadius: BorderRadius.circular(7)),
        child:
            Text(level, style: PrimaryStyle.regular(16, color: Colors.white)));
  } else if (level == "Trung bình") {
    return Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: kOrangeColor800, borderRadius: BorderRadius.circular(7)),
        child:
            Text(level, style: PrimaryStyle.regular(16, color: Colors.white)));
  }
  return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: kBlueColor500, borderRadius: BorderRadius.circular(7)),
      child: Text(level, style: PrimaryStyle.regular(16, color: Colors.white)));
}

Widget itemText(String title, String content, int status) {
  return RichText(
      text: TextSpan(
          text: title,
          style: PrimaryStyle.medium(16,
              color: status == 1 ? Colors.white : kIndigoBlueColor900),
          children: [
        TextSpan(
          text: content,
          style: PrimaryStyle.normal(16,
              color: status == 1 ? Colors.white : kIndigoBlueColor900),
        )
      ]));
}
