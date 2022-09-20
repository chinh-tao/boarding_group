import 'package:boarding_group/app/common/config.dart';
import 'package:boarding_group/app/modules/login/views/body/body_list_account.dart';
import 'package:boarding_group/app/modules/login/views/body/custom_menu.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/list_account_controller.dart';

class ListAccountView extends GetView<ListAccountController> {
  const ListAccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kPrimaryColor,
      body: BodyListAccount(),
      floatingActionButton: CustomMenu(),
    );
  }
}
