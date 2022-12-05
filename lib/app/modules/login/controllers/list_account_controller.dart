import 'package:boarding_group/app/common/global.dart';
import 'package:boarding_group/app/model/user_model.dart';
import 'package:boarding_group/app/modules/login/views/body/body_bottom_sheet.dart';
import 'package:boarding_group/app/routes/app_pages.dart';
import 'package:boarding_group/app/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../common/auth.dart';
import '../../password/views/forgot_pass_view.dart';

class ListAccountController extends ChangeNotifier {
  final forgotPassErr = "";
  var isLoading = false;
  var isHideMenu = false;
  var listUser = <UserModel>[];

  final _log = Logger();

  void initData(context) {
    listUser = ModalRoute.of(context)!.settings.arguments as List<UserModel>;
    notifyListeners();
  }

  void showBottomSheet(int index, WidgetRef ref) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: navKey.currentContext!,
        constraints: const BoxConstraints(maxHeight: 110), //110
        builder: (context) {
          return BodyBottomSheet(
              removeAccount: () async {
                navKey.currentState!.pop();
                showRemoveAccount(index, ref);
              },
              user: listUser[index]);
        });
  }

  Future<void> handleRemoveAccount(String email, WidgetRef ref) async {
    final form = {'email': email, 'device_mobi': ref.watch(Auth.device)};

    isLoading = true;
    notifyListeners();
    final res = await api.delete('/remove-account', data: form);
    isLoading = false;
    if (res.statusCode == 200 && res.data['code'] == 0) {
      listUser.removeWhere((data) => data.email!.contains(email));
      if (listUser.isNotEmpty) {
        Utils.messSuccess(res.data['message']);
      } else {
        navKey.currentState!
            .pushNamed(Routes.LOGIN, arguments: {'category': '0'});
      }
    } else {
      Utils.messError(res.data['message']);
    }
    notifyListeners();
  }

  void showRemoveAccount(int index, WidgetRef ref) async {
    Utils.showMessPopup(
        content: 'Bạn có muốn gỡ tài khoản này?',
        onPressed: () async {
          navKey.currentState!.pop();
          await handleRemoveAccount(listUser[index].email!, ref);
        });
  }

  void showForgotPass() {
    isHideMenu = false;
    notifyListeners();
    showDialog(
        context: navKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: const ForgotPassView(),
          );
        });
  }

  void handleShowPage() {
    isHideMenu = false;
    notifyListeners();
    navKey.currentState!.pushNamed(Routes.LOGIN, arguments: {'category': '2'});
  }

  void handleShowMenu() {
    isHideMenu = !isHideMenu;
    notifyListeners();
  }
}

final listAccountController = ChangeNotifierProvider<ListAccountController>(
    (ref) => ListAccountController());
