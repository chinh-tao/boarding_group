import 'package:boarding_group/app/modules/home/views/components/body/search_list_member.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/global.dart';

class RootController extends ChangeNotifier {
  GlobalKey<NavigatorState> rootKey = GlobalKey<NavigatorState>();
  var index = 0;
  var isSelected = <bool>[true, false, false, false];

  void handleChangeIndex(int position) {
    index = position;
    isSelected = isSelected.map((data) => data = false).toList();
    isSelected[position] = true;
    notifyListeners();
    Navigator.of(navKey.currentContext!).pop();
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
}

final rootController =
    ChangeNotifierProvider<RootController>((ref) => RootController());
