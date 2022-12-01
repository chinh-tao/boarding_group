import 'package:boarding_group/app/modules/incident/controller/incident_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/config.dart';
import '../../../common/global.dart';
import '../../../common/primary_style.dart';
import '../../../model/incident_model.dart';
import '../../../widget/item/item_invoice.dart';

class IncidentDetail extends ConsumerWidget {
  const IncidentDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index =
        int.parse(ModalRoute.of(context)!.settings.arguments.toString());
    final listIncident = ref.watch(incidentController).listIncident[index];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text("Chi tiết sự cố", style: PrimaryStyle.normal(20)),
        leading: IconButton(
            onPressed: () => navKey.currentState!.pop(),
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text('${listIncident.title}',
                      textAlign: TextAlign.center,
                      style: PrimaryStyle.normal(20, color: kBodyText))),
              const SizedBox(height: 5),
              Center(
                  child: RichText(
                text: TextSpan(
                    text: '(Tên: ${listIncident.userName}, mức độ: ',
                    style: PrimaryStyle.normal(12, color: kBodyText),
                    children: [
                      TextSpan(
                          text: '${listIncident.level}',
                          style: PrimaryStyle.normal(12,
                              color: colorLever(listIncident.level!))),
                      TextSpan(
                          text: ')',
                          style: PrimaryStyle.normal(12, color: kBodyText))
                    ]),
              )),
              const SizedBox(height: 10),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ItemInvoice(
                      title: "",
                      content: "${listIncident.date}",
                      color2: listIncident.status == 1
                          ? kGreenColor700
                          : kBodyText)),
              const Divider(thickness: 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text("${listIncident.content}",
                    style: PrimaryStyle.medium(16, color: kBodyText)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Color colorLever(String level) {
  if (level == "Cao") {
    return kRedColor600;
  } else if (level == "Trung bình") {
    return kOrangeColor800;
  }
  return kBodyText;
}
