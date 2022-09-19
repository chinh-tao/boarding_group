import 'package:boarding_group/app/common/config.dart';
import 'package:boarding_group/app/modules/login/views/body/body_list_account.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/list_account_controller.dart';

class ListAccountView extends GetView<ListAccountController> {
  const ListAccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: const BodyListAccount(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kOrangeColor800,
        onPressed: () =>
            Get.toNamed(Routes.LOGIN, parameters: {'category': '2'}),
        child: const Icon(Icons.add, color: kWhiteColor, size: 27),
      ),
    );
  }
}
