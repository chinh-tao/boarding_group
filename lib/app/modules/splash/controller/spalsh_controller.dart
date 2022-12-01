import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import '../../../common/auth.dart';
import '../../../common/global.dart';
import '../../../model/user_model.dart';
import '../../../routes/app_pages.dart';
import '../../../common/utils.dart';

class SplashController extends ChangeNotifier {
  Future<File> get localPath async {
    final director = await getTemporaryDirectory();
    final path =
        director.path.substring(0, director.path.indexOf('/Application'));
    return File('$path/devices.txt');
  }

  Future<String> get getIdDevice async {
    if (Platform.isIOS) {
      final file = await localPath;
      if (!await file.exists()) {
        var idDevice = await Utils.getDevice();
        await file.writeAsString(idDevice);
      }
      return await file.readAsString();
    }
    return await Utils.getDevice();
  }

  Future<void> checkDevice(WidgetRef ref) async {
    ref.read(Auth.device.notifier).state = await getIdDevice;
    final form = {"device_mobi": ref.watch(Auth.device)};
    final res = await api.get('/check-device', queryParameters: form);
    if (res.statusCode == 200 && res.data['code'] == 0) {
      final dataUser = res.data['payload']['data_user'] as List;
      final hasDevice = res.data['payload']['has_device'] as bool;
      if (dataUser.isNotEmpty) {
        final listUser =
            dataUser.map((data) => UserModel.fromJson(data)).toList();
        navKey.currentState!.pushNamedAndRemoveUntil(
            Routes.LIST_ACCOUNT, (route) => false,
            arguments: listUser);
      } else {
        if (!hasDevice) {
          navKey.currentState!
              .pushNamedAndRemoveUntil(Routes.REGISTER, (route) => false);
          return;
        }
        navKey.currentState!.pushNamedAndRemoveUntil(
            Routes.LOGIN, (route) => false,
            arguments: {'category': '0'});
      }
    } else {
      Utils.messError(res.data['message']);
    }
  }
}

final splashController =
    ChangeNotifierProvider<SplashController>((ref) => SplashController());
