import 'package:boarding_group/app/common/api.dart';
import 'package:boarding_group/app/model/user_model.dart';
import 'package:boarding_group/app/routes/app_pages.dart';
import 'package:boarding_group/app/utils/utils.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class AuthController extends GetxController {
  // setup in app
  final user = UserModel().obs;
  final _log = Logger();
  final device = ''.obs;
  final listUser = <UserModel>[].obs;

  // save images to fire store
  late FirebaseStorage storage;

  // get device
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void initData() async {
    storage = FirebaseStorage.instance;
  }

  Future<void> checkDevice() async {
    device.value = await Utils.getDevice();
    final form = {"device_mobi": device.value};
    final res = await api.get('/check-device', queryParameters: form);
    if (res.statusCode == 200 && res.data['code'] == 0) {
      final dataUser = res.data['payload']['data_user'];
      final hasDevice = res.data['payload']['has_device'] as bool;
      if (dataUser != null) {
        final convertList = dataUser as List;
        listUser.value =
            convertList.map((data) => UserModel.fromJson(data)).toList();
        Get.offNamed(Routes.LIST_ACCOUNT);
      } else {
        if (!hasDevice) {
          Get.offNamed(Routes.REGISTER);
          return;
        }
        Get.offNamed(Routes.LOGIN, parameters: {'category': '0'});
      }
    } else {
      Utils.messError(res.data['message']);
    }
  }
}
