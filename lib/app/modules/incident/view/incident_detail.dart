import 'package:boarding_group/app/common/auth.dart';
import 'package:boarding_group/app/model/incident_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/config.dart';
import '../../../common/global.dart';
import '../../../common/primary_style.dart';
import '../controller/incident_controller.dart';

class IncidentDetail extends ConsumerWidget {
  const IncidentDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index =
        int.parse(ModalRoute.of(context)!.settings.arguments.toString());
    final listIncident = ref.watch(Auth.lisIncident)[index];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text("Chi tiết sự cố", style: PrimaryStyle.normal(20)),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
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
                      style:
                          PrimaryStyle.medium(20, color: kIndigoBlueColor900))),
              const SizedBox(height: 5),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: itemText(
                      "${listIncident.level}", "${listIncident.date}",
                      color: colorLever(listIncident.level!))),
              const Divider(thickness: 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text("${listIncident.content}",
                    style: PrimaryStyle.medium(16, color: kIndigoBlueColor900)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget itemText(String title, String content, {Color? color}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title,
          style: PrimaryStyle.medium(16, color: color ?? kIndigoBlueColor900)),
      Text(content, style: PrimaryStyle.medium(16, color: kIndigoBlueColor900)),
    ],
  );
}

Color colorLever(String level) {
  if (level == "Cao") {
    return kRedColor600;
  } else if (level == "Trung bình") {
    return kOrangeColor800;
  }
  return kIndigoBlueColor900;
}
