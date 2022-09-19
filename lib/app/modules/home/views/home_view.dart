import 'package:boarding_group/app/modules/home/views/components/body/Body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Games caro vip pro'),
        centerTitle: true,
      ),
      body: SizedBox(height: Get.height, child: const Body()),
    );
  }
}
