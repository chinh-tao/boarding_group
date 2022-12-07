import 'package:boarding_group/app/common/config.dart';
import 'package:boarding_group/app/modules/home/views/components/body/search_list_member.dart';
import 'package:boarding_group/app/modules/splash/controller/spalsh_controller.dart';
import 'package:boarding_group/app/widget/button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/auth.dart';
import '../../../common/global.dart';
import '../../../common/primary_style.dart';
import '../../../routes/app_pages.dart';
import '../../bill/view/components/search_month.dart';

class RootController extends ChangeNotifier {
  RootController(this.ref);

  GlobalKey<ScaffoldState> rootKey = GlobalKey<ScaffoldState>();

  final Ref ref;
  var isHideMenu = false;
  var index = 0;
  var isSelected = <bool>[true, false, false, false, false, false];

  void handleChangeIndex(int position) async {
    Navigator.of(navKey.currentContext!).pop();
    if (position == 5) {
      box.remove('idBranch');
      await ref.read(splashController.notifier).checkDevice(isLoading: true);
    } else if (position == 4) {
      showInforAdmin();
    } else {
      index = position;
      isSelected = isSelected.map((data) => data = false).toList();
      isSelected[position] = true;
      notifyListeners();
    }
  }

  void showSearchView() {
    showDialog(
        context: navKey.currentContext!,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              content: const SearchListMember());
        });
  }

  void showSearchBillView() {
    showDialog(
        context: navKey.currentContext!,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              content: const SearchMonth());
        });
  }

  void handleShowMenu() {
    isHideMenu = !isHideMenu;
    notifyListeners();
  }

  void showPage() {
    isHideMenu = false;
    notifyListeners();
    navKey.currentState!.pushNamed(Routes.ADD_INCIDENT);
  }

  void showFormSearch() {
    isHideMenu = false;
    notifyListeners();
    rootKey.currentState!.openEndDrawer();
  }

  void showInforAdmin() {
    showDialog(
        barrierDismissible: false,
        context: navKey.currentContext!,
        builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: kWhiteColor,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
                children: [
                  RichText(
                      overflow: TextOverflow.clip,
                      text: TextSpan(
                          text: "Quản trị viên:",
                          style: PrimaryStyle.bold(22, color: kBodyText),
                          children: [
                            TextSpan(
                                text: ref.watch(Auth.admin).getName,
                                style:
                                    PrimaryStyle.normal(20, color: kBodyText))
                          ])),
                  const SizedBox(height: 5),
                  RichText(
                      overflow: TextOverflow.clip,
                      text: TextSpan(
                          text: "Điện thoại:",
                          style: PrimaryStyle.bold(22, color: kBodyText),
                          children: [
                            TextSpan(
                                text: ref.watch(Auth.admin).getPhone,
                                style:
                                    PrimaryStyle.normal(20, color: kBodyText))
                          ])),
                  const SizedBox(height: 20),
                  PrimaryButton(
                      height: 50,
                      sizeContent: 20,
                      width: double.infinity,
                      content: 'Đóng',
                      onPressed: () => navKey.currentState!.pop())
                ],
              ),
            ));
  }
}

final rootController = ChangeNotifierProvider.autoDispose<RootController>(
    (ref) => RootController(ref));
