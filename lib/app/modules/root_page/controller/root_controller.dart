import 'package:flutter/material.dart';

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
}
