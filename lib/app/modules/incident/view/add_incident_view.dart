import 'package:boarding_group/app/widget/button/primary_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../../common/config.dart';
import '../../../common/global.dart';
import '../../../common/primary_style.dart';
import '../../../widget/custom_input.dart';
import '../controller/incident_controller.dart';

class AddIncidentView extends ConsumerStatefulWidget {
  const AddIncidentView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AddIncidentViewState();
}

class _AddIncidentViewState extends ConsumerState<AddIncidentView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(incidentController.notifier).initData(ref, isList: false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final watch = ref.watch(incidentController);
    final read = ref.read(incidentController);

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Text("Thêm sự cố", style: PrimaryStyle.normal(20)),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomInput(
                          title: "Tên sự cố",
                          controller: watch.titleController,
                          err: watch.listErr[0]),
                      Text("Mức độ",
                          style: PrimaryStyle.medium(17, color: kBodyText)),
                      const SizedBox(height: 5),
                      InputDecorator(
                        decoration: InputDecoration(
                            hintText: "Mức độ",
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 1,
                                    color: kBlackColor900.withOpacity(0.8)))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: watch.leverText,
                            onChanged: (value) =>
                                read.incidentOnChanged(value!),
                            items: watch.levers.map((value) {
                              return DropdownMenuItem(
                                  value: value, child: Text(value));
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomInput(
                          title: "Tên người thông báo",
                          readOnly: true,
                          background: kGreyColor400,
                          controller: watch.nameController,
                          err: ''),
                      CustomInput(
                          title: "Số phòng",
                          readOnly: true,
                          background: kGreyColor400,
                          controller: watch.roomController,
                          err: ''),
                      CustomInput(
                          title: "Nội dung",
                          controller: watch.contentController,
                          maxLines: 5,
                          err: watch.listErr[1]),
                      const SizedBox(height: 20),
                      Center(
                          child: PrimaryButton(
                              height: 50,
                              width: size.width,
                              content: "Gửi yêu cầu",
                              sizeContent: 18,
                              isLoading:
                                  ref.watch(incidentController).isLoading,
                              onPressed: () => watch.sendIncident(ref))),
                    ]))));
  }
}
