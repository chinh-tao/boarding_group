import 'dart:async';
import 'dart:io';

import 'package:boarding_group/app/common/api.dart';
import 'package:boarding_group/app/common/config.dart';
import 'package:boarding_group/app/modules/auth/auth_controller.dart';
import 'package:boarding_group/app/modules/register/views/body/body_bottom_sheet.dart';
import 'package:boarding_group/app/routes/app_pages.dart';
import 'package:boarding_group/app/utils/utils.dart';
import 'package:dio/dio.dart' as dio;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class RegisterController extends GetxController {
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputCode = TextEditingController();
  TextEditingController inputName = TextEditingController();

  final isLoadImage = false.obs;
  final isLoading = false.obs;
  final isLoadUser = false.obs;
  final listError = ["", ""].obs;

  final _log = Logger();
  final fileImage = File("").obs;
  final AuthController authController = Get.find();

  Timer? time;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    inputEmail.dispose();
    inputCode.dispose();
    super.onClose();
  }

  bool get validator {
    var result = true;
    listError.value = ["", ""];

    if (inputCode.text.trim().isEmpty) {
      listError[0] = "vui lòng không để trống thông tin";
      result = false;
    } else if (inputCode.text.trim().length < 12) {
      listError[0] = "không khớp với định dạng";
      result = false;
    }
    if (inputEmail.text.trim().isEmpty) {
      listError[1] = "vui lòng không để trống thông tin";
      result = false;
    } else if (!inputEmail.text.isEmail) {
      listError[1] = "địa chỉ email không hợp lệ";
      result = false;
    }
    update();
    return result;
  }

  Future<void> submit() async {
    if (!validator) return;
    await registerAccount();
  }

  Future<void> showModalSheet() async {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: Get.context!,
        constraints: const BoxConstraints(maxHeight: 150),
        builder: (context) {
          return BodyBottomSheet(
              imageCamera: () => handlePickerImage(ImageSource.camera),
              pickerImage: () => handlePickerImage(ImageSource.gallery),
              removeAvatar: () {
                Get.back();
                fileImage.value = File('');
                update();
              });
        });
  }

  Future<void> handlePickerImage(ImageSource source) async {
    Get.back();
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image != null) {
        fileImage.value = File(image.path);
      }
      update();
    } on PlatformException catch (err) {
      _log.e("Image: $err");
      Utils.messWarning(MSG_SYSTEM_HANDLE);
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse res = await ImagePicker().retrieveLostData();
    if (res.isEmpty) return;
    if (res.file != null) {
      fileImage.value = File(res.file!.path);
      update();
    } else {
      _log.e("Image(retrieveLostData): ${res.exception!.code}");
      Utils.messWarning(MSG_SYSTEM_HANDLE);
    }
  }

  Future<String> get getUrlImage async {
    var urlImage = '';
    try {
      Reference ref = authController.storage
          .refFromURL('gs://boarding-group.appspot.com')
          .child(inputCode.text);
      UploadTask task = ref.putFile(fileImage.value);
      urlImage = await task.snapshot.ref.getDownloadURL();
    } catch (err) {
      _log.e('Fire Store: $err');
      Utils.messWarning(MSG_SAVE_FILE);
    }
    return urlImage;
  }

  Future<void> registerAccount() async {
    final form = <String, dynamic>{
      "id": inputCode.text,
      "email": inputEmail.text,
      "images": await dio.MultipartFile.fromFile(fileImage.value.path,
          filename: inputCode.text),
      "device_mobi": authController.device.value
    };
    isLoading.value = true;
    final res = await api.post('/register',
        data: form,
        options: dio.Options(contentType: 'application/x-www-form-urlencoded'));
    isLoading.value = false;
    if (res.statusCode == 200 && res.data['code'] == 0) {
      // if (fileImage.value.path != '') {
      //   handeSaveImage();
      // } else {
      Get.offNamed(Routes.LOGIN, parameters: {'category': '0'});
      // }
    } else {
      Utils.messError(res.data['message']);
    }
    update();
  }

  void handeSaveImage() async {
    var url = await getUrlImage;
    print(url);
    if (url != '') {
      final res = await api.post('/register', data: {"images": url});
      if (res.statusCode == 200 && res.data['code'] == 0) {
        print('success');
      }
      //Get.offNamed(Routes.LOGIN, parameters: {'category': '0'});
    } else {
      while (url != '') {
        handeSaveImage();
      }
    }
  }

  Future<void> handleCheckUser(String value) async {
    final form = {"id": value};
    final res = await api.post('/check-user', data: form);
    if (res.statusCode == 200 && res.data['code'] == 0) {
      inputName.text = res.data['payload'].toString();
    } else if (res.data['code'] == 400) {
      inputName.clear();
    } else {
      Utils.messError(res.data['message']);
    }
    update();
  }

  void handleChangeInputName(String value) {
    time = Timer(const Duration(milliseconds: 200), () {
      handleCheckUser(value);
    });
  }
}
