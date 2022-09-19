import 'package:get/get.dart';

import '../controllers/list_account_controller.dart';

class ListAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListAccountController>(
      () => ListAccountController(),
    );
  }
}
