import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common/config.dart';
import '../../../../common/global.dart';
import '../../../../common/primary_style.dart';
import '../../../../routes/app_pages.dart';
import '../../controller/incident_controller.dart';

class ListIncident extends ConsumerWidget {
  const ListIncident({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(incidentController).listIncident.isEmpty) {
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
        itemCount: ref.watch(incidentController).listIncident.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final listIncident =
              ref.watch(incidentController).listIncident[index];
          return Card(
            elevation: 5,
            color: listIncident.status == 1 ? kGreenColor700 : null,
            margin: const EdgeInsets.all(6),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              onTap: () => navKey.currentState!
                  .pushNamed(Routes.INCIDENTDETAIL, arguments: index),
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstrainedBox(
                          constraints:
                              BoxConstraints(maxWidth: size.width / 1.5),
                          child: !hasTextOverflow(
                                  'Tên sự cố: ${listIncident.title}')
                              ? itemText('Tên sự cố:', " ${listIncident.title}",
                                  listIncident.status!)
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxWidth: size.width / 1.75),
                                        child: Text(
                                            'Tên sự cố: ${listIncident.title}',
                                            maxLines: 1,
                                            overflow: TextOverflow.visible,
                                            style: PrimaryStyle.medium(16,
                                                color: listIncident.status == 1
                                                    ? Colors.white
                                                    : kIndigoBlueColor900)),
                                      ),
                                      Text("...",
                                          style: PrimaryStyle.medium(16,
                                              color: listIncident.status == 1
                                                  ? Colors.white
                                                  : kIndigoBlueColor900))
                                    ]),
                        ),
                        showLevel("${listIncident.level}")
                      ],
                    ),
                    const SizedBox(height: 5),
                    itemText('Người thông báo:', " ${listIncident.userName}",
                        listIncident.status!),
                    const SizedBox(height: 5),
                    itemText('Ngày thông báo:', " ${listIncident.date}",
                        listIncident.status!)
                  ],
                ),
              ),
            ),
          );
        });
  }
}

Widget showLevel(String level) {
  if (level == "Cao") {
    return Container(
        padding: const EdgeInsets.all(3.5),
        decoration: BoxDecoration(
            color: kRedColor600, borderRadius: BorderRadius.circular(5)),
        child:
            Text(level, style: PrimaryStyle.regular(12, color: Colors.white)));
  } else if (level == "Trung bình") {
    return Container(
        padding: const EdgeInsets.all(3.5),
        decoration: BoxDecoration(
            color: kOrangeColor800, borderRadius: BorderRadius.circular(5)),
        child:
            Text(level, style: PrimaryStyle.regular(12, color: Colors.white)));
  }
  return Container(
      padding: const EdgeInsets.all(3.5),
      decoration: BoxDecoration(
          color: kIndigoBlueColor900, borderRadius: BorderRadius.circular(5)),
      child: Text(level, style: PrimaryStyle.regular(12, color: Colors.white)));
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

bool hasTextOverflow(String text) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(
        text: text, style: PrimaryStyle.normal(16, color: kIndigoBlueColor900)),
    maxLines: 1,
    textDirection: TextDirection.rtl,
  )..layout(minWidth: 0, maxWidth: size.width / 1.7);
  return textPainter.didExceedMaxLines;
}
