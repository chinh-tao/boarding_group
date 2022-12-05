import 'dart:async';
import 'dart:io';

import 'package:boarding_group/app/common/global.dart';
import 'package:boarding_group/app/common/primary_style.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import 'config.dart';

class Utils {
  static void handleUnfocus() {
    FocusScopeNode focusNode = FocusScope.of(navKey.currentContext!);
    if (!focusNode.hasPrimaryFocus && focusNode.hasFocus) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  static String formatNumber(String s) =>
      NumberFormat.decimalPattern().format(s.isEmpty ? 0 : int.parse(s));

  static void showMessage(
      {required Color color,
      required String text,
      int duration = 0,
      AlignmentGeometry alignment = Alignment.center,
      TextAlign textAlign = TextAlign.center,
      Function()? onPressed}) {
    showDialog(
        context: navKey.currentContext!,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Column(children: [
                Align(
                  alignment: alignment,
                  child: Text(text,
                      style: const TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: textAlign),
                ),
                if (duration == 0) ...[
                  const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 15),
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            fixedSize: const Size(100, 45),
                            side: const BorderSide(
                                color: Colors.white, width: 2)),
                        onPressed: onPressed,
                        child: const Text("OK",
                            style:
                                TextStyle(fontSize: 14, color: Colors.white))),
                  )
                ]
              ]),
              titlePadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              content: SizedBox(width: size.width),
              contentPadding: EdgeInsets.zero,
              actionsPadding: EdgeInsets.zero,
              insetPadding: EdgeInsets.zero,
              backgroundColor: color,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0))),
            ),
          );
        });

    //sau 1s dialog tự động tắt
    if (duration != 0) {
      Future.delayed(Duration(milliseconds: duration), () {
        Navigator.of(navKey.currentContext!).pop();
      });
    }
  }

  static void messWarning(String content) {
    showMessage(
        onPressed: () => Navigator.of(navKey.currentContext!).pop(),
        alignment: Alignment.centerLeft,
        textAlign: TextAlign.left,
        color: kYellowColor800,
        text: content);
  }

  static void messError(String content) {
    showMessage(
        onPressed: () => Navigator.of(navKey.currentContext!).pop(),
        alignment: Alignment.centerLeft,
        textAlign: TextAlign.left,
        color: kRedColor600,
        text: content);
  }

  static void messSuccess(String content) {
    showMessage(
        duration: 1500,
        alignment: Alignment.center,
        textAlign: TextAlign.left,
        color: kGreenColor700,
        text: content);
  }

  static void showMessPopup({required String content, Function()? onPressed}) {
    showDialog(
        context: navKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Text(content,
                style: PrimaryStyle.medium(20, color: kIndigoBlueColor900)),
            contentPadding:
                const EdgeInsets.only(bottom: 5, top: 23, left: 20, right: 20),
            actions: [
              TextButton(
                  onPressed: () => navKey.currentState!.pop(),
                  child: Text(
                    'hủy',
                    style: PrimaryStyle.medium(18, color: kIndigoBlueColor900),
                  )),
              TextButton(
                  onPressed: onPressed,
                  child: Text(
                    'xác nhận',
                    style: PrimaryStyle.medium(18, color: kRedColor400),
                  ))
            ],
          );
        });
  }

  static void showPopupLoading() {
    showDialog(
        barrierDismissible: false,
        context: navKey.currentContext!,
        builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'vui lòng đợi trong giây lát...',
                          style: PrimaryStyle.normal(16, color: Colors.white),
                        )
                      ]),
                    )
                  ]),
            ));
  }

  static Future<String> getDevice() async {
    final DeviceInfoPlugin _device = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo android = await _device.androidInfo;
      return android.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo ios = await _device.iosInfo;
      return "${ios.identifierForVendor}";
    }
    return 'Zzz...';
  }

  static Future<File> handlePickerImage(ImageSource source) async {
    navKey.currentState!.pop();
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) return File(image.path);
    return File("");
  }

  static String getTypeImage(String path) {
    final filedName = path.split('/').last;
    final typeFiled = filedName.split('.').last;
    return typeFiled;
  }

  static Future<String> showMonth({DateTime? initialDate}) async {
    final format = DateFormat("yyyy-MM");

    DateTime? pickedMonth = await showMonthPicker(
        context: navKey.currentContext!,
        initialDate:
            initialDate ?? DateTime(DateTime.now().year, DateTime.now().month),
        firstDate: DateTime(2018),
        lastDate: DateTime(DateTime.now().year, DateTime.now().month),
        locale: const Locale('vi'));
    if (pickedMonth != null) {
      return format.format(pickedMonth);
    }
    return '';
  }

  static Future<String> selectDate({required DateTime initialDate}) async {
    final format = DateFormat("yyyy-MM-dd");
    DateTime? pickedDate = await showDatePicker(
        context: navKey.currentContext!,
        initialDate: initialDate,
        locale: const Locale('vi'),
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year + 3));
    if (pickedDate != null) {
      return format.format(pickedDate);
    }
    return '';
  }
}
