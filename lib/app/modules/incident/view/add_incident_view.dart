import 'package:boarding_group/app/widget/button/primary_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../../common/config.dart';
import '../../../common/global.dart';
import '../../../common/primary_style.dart';
import '../../../widget/custom_input.dart';
import '../../../widget/drop_down/button_down_form.dart';
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
      ref.read(incidentController.notifier).initData(isList: false);
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
              onPressed: () {
                read.nameController.clear();
                navKey.currentState!.pop();
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomInput(
                  title: "Tên sự cố",
                  controller: watch.titleController,
                  err: watch.listErr[0]),
              ButtonDownForm(
                  title: "Mức độ",
                  value: watch.leverText,
                  list: watch.levers,
                  onChanged: (value) => read.incidentOnChangedLever(value!)),
              const SizedBox(height: 10),
              CustomInput(
                  title: "Tên người thông báo",
                  readOnly: true,
                  background: kGreyColor400,
                  controller: watch.nameSearchController,
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
              PrimaryButton(
                  height: 50,
                  width: size.width,
                  sizeContent: 18,
                  isLoading: ref.watch(incidentController).isLoadingButton,
                  content: "Thêm sự cố",
                  onPressed: () => watch.sendIncident()),
            ]),
          ),
        ));
  }
}
