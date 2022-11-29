import 'package:boarding_group/app/common/global.dart';
import 'package:boarding_group/app/model/incident_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../common/auth.dart';
import '../../../common/utils.dart';

class IncidentController extends ChangeNotifier {
  var lisIncident = <IncidentModel>[];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController roomController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  final levers = ['Cao', 'Trung bình', 'Thấp'];
  var isLoading = false;
  var isLoadingButton = false;
  var listErr = ["", ""];
  var leverText = "Thấp";

  void initData(WidgetRef ref, {bool isList = true}) async {
    roomController.text = ref.watch(Auth.user).getRoomNumber;
    if (isList) {
      loadDataIncident(ref);
    } else {
      nameController.text = ref.watch(Auth.user).getUserName;
    }
  }

  // list incident
  Future<void> loadDataIncident(WidgetRef ref, {bool isRefresh = false}) async {
    final form = <String, dynamic>{"room": roomController.text};
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

  void incidentOnChanged(String value) {
    leverText = value;
    notifyListeners();
  }

  // add incident
  bool get validator {
    var result = true;
    listErr = ["", ""];
    if (titleController.text.trim().isEmpty) {
      listErr[0] = 'Tên sự cố không được để trống';
      result = false;
    }

    if (contentController.text.trim().isEmpty) {
      listErr[1] = 'Nội dung không được để trống';
      result = false;
    }
    notifyListeners();
    return result;
  }

  void sendIncident(WidgetRef ref) async {
    Utils.handleUnfocus();
    if (!validator) return;
    isLoadingButton = true;
    final form = <String, dynamic>{
      "title": titleController.text.trim(),
      "date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
      "level": leverText,
      "user_name": nameController.text,
      "room": roomController.text,
      "content": contentController.text.trim()
    };
    final res = await api.post('/room-incident', data: form);
    if (res.statusCode == 200 && res.data["code"] == 0) {
      Utils.messSuccess(res.data["message"]);
      await loadDataIncident(ref);
      isLoadingButton = false;
      Navigator.pop(navKey.currentContext!);
      notifyListeners();
    } else {
      Utils.messError(res.data["message"]);
    }
    notifyListeners();
  }
}

final incidentController =
    ChangeNotifierProvider<IncidentController>((ref) => IncidentController());
