import 'package:boarding_group/app/common/api.dart';
import 'package:boarding_group/app/model/incident_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/auth.dart';
import '../../../common/utils.dart';

class ListIncidentController extends ChangeNotifier {
  // final TextEditingController nameController = TextEditingController();
  // final TextEditingController levelController = TextEditingController();

  var lisIncident = <IncidentModel>[];
  var isLoading = false;

  Future<void> initData(WidgetRef ref, {bool isRefresh = false}) async {
    final form = <String, dynamic>{"room":302};
    if (!isRefresh) isLoading = true;
    notifyListeners();
    final res = await api.get('/list-incident', queryParameters: form);
    if (!isRefresh) isLoading = false;
    if (res.statusCode == 200) {
      if (res.data['code'] == 0) {
        final convert = res.data['payload'] as List;
        lisIncident =
            convert.map((data) => IncidentModel.fromJson(data)).toList();
      } else {
        lisIncident.clear();
      }
      notifyListeners();
    } else {
      Utils.messError(res.data['message']);
    }
  }
}
