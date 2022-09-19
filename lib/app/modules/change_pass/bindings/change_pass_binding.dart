import 'package:get/get.dart';

import '../controllers/change_pass_controller.dart';

class ChangePassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePassController>(
      () => ChangePassController(),
    );
  }
}
