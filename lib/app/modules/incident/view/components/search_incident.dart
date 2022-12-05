import 'package:boarding_group/app/common/config.dart';
import 'package:boarding_group/app/modules/incident/controller/incident_controller.dart';
import 'package:boarding_group/app/widget/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/global.dart';
import '../../../../widget/button/primary_button.dart';
import '../../../../widget/drop_down/button_down_form.dart';

class SearchIncident extends ConsumerStatefulWidget {
  const SearchIncident({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _SearchIncidentState();
}

class _SearchIncidentState extends ConsumerState<SearchIncident> {
  @override
  Widget build(BuildContext context) {
    final watch = ref.watch(incidentController);
    final read = ref.read(incidentController);

    return Drawer(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  CustomInput(
                      title: 'Tên người thông báo',
                      controller: watch.nameController,
                      err: ''),
                  ButtonDownForm(
                      keyDropdown: watch.keyDropDownLevel,
                      title: "Mức độ",
                      value: watch.leverSearch,
                      list: watch.leversSearch,
                      onChanged: (value) =>
                          read.incidentOnChangedLeverSearch(value!)),
                  const SizedBox(height: 10),
                  ButtonDownForm(
                      keyDropdown: watch.keyDropDownStatus,
                      title: "Trạng thái",
                      value: watch.statusSearch,
                      list: watch.status,
                      onChanged: (value) =>
                          read.incidentOnChangedStatus(value!)),
                  const SizedBox(height: 10),
                  CustomInput(
                      title: 'Ngày thông báo',
                      controller: watch.dateSearchController,
                      readOnly: true,
                      onTap: () => watch.showDateSearch(),
                      err: ''),
                  const SizedBox(height: 20),
                  PrimaryButton(
                      height: 50,
                      width: size.width,
                      sizeContent: 18,
                      isLoading: false,
                      colors: color[500],
                      content: "Làm mới",
                      onPressed: () => read.clearInput()),
                  const SizedBox(height: 10),
                  PrimaryButton(
                      height: 50,
                      width: size.width,
                      sizeContent: 18,
                      isLoading: ref.watch(incidentController).isLoadingButton,
                      content: "Tim kiếm",
                      onPressed: () async {
                        navKey.currentState!.pop();
                        await read.loadDataIncident(ref);
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
