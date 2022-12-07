import 'package:boarding_group/app/common/global.dart';
import 'package:boarding_group/app/model/incident_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../common/auth.dart';
import '../../../common/utils.dart';

class IncidentController extends ChangeNotifier {
  IncidentController(this.ref);

  final GlobalKey<FormFieldState> keyDropDownLevel =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> keyDropDownStatus =
      GlobalKey<FormFieldState>();
  var listIncident = <IncidentModel>[];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nameSearchController = TextEditingController();
  final TextEditingController roomController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController dateSearchController = TextEditingController();

  final Ref ref;
  final levers = ['Cao', 'Trung bình', 'Thấp'];
  final leversSearch = ['Tất cả', 'Cao', 'Trung bình', 'Thấp'];
  final status = ['Tất cả', 'Đang xử lý', 'Đã xử lý'];
  var isLoading = false;
  var isLoadingButton = false;
  var listErr = ["", ""];
  var leverText = "Thấp";
  var leverSearch = "Tất cả";
  var statusSearch = "Tất cả";

  void initData({bool isList = true}) async {
    roomController.text = ref.watch(Auth.user).getRoomNumber;
    if (isList) {
      clearInput(isRoot: true);
      loadDataIncident();
    } else {
      nameController.text = ref.watch(Auth.user).getUserName;
      listErr = ["", ""];
      titleController.clear();
      contentController.clear();
      notifyListeners();
    }
  }

  // list incident
  Future<void> loadDataIncident({bool isRefresh = false}) async {
    final form = <String, dynamic>{"room": roomController.text.trim()};

    if (nameController.text.isNotEmpty) {
      form['user_name'] = nameSearchController.text.trim();
    }

    if (statusSearch != "Tất cả") {
      form['status'] = statusSearch == 'Đang xử lý' ? 0 : 1;
    }

    if (leverSearch != "Tất cả") {
      form['level'] = leverSearch;
    }

    if (dateSearchController.text.isNotEmpty) {
      form['date'] = dateSearchController.text.trim();
    }

    print("form123: $form");

    if (!isRefresh) isLoading = true;
    notifyListeners();
    final res = await api.get('/list-incident', queryParameters: form);
    if (!isRefresh) isLoading = false;
    if (res.statusCode == 200) {
      if (res.data['code'] == 0) {
        final convert = res.data['payload'] as List;
        listIncident =
            convert.map((data) => IncidentModel.fromJson(data)).toList();
      } else {
        listIncident.clear();
      }
    } else {
      Utils.messError(res.data['message']);
    }
    notifyListeners();
  }

  void incidentOnChangedLever(String value) {
    leverText = value;
    notifyListeners();
  }

  void incidentOnChangedLeverSearch(String value) {
    leverSearch = value;
    notifyListeners();
  }

  void incidentOnChangedStatus(String value) {
    statusSearch = value;
    notifyListeners();
  }

  void showDateSearch() async {
    final date = await Utils.selectDate(
        initialDate: dateSearchController.text.isEmpty
            ? DateTime.now()
            : DateTime.parse(dateSearchController.text));
    if (date.isNotEmpty) {
      dateSearchController.text = date;
    }
  }

  void clearInput({bool isRoot = false}) {
    nameSearchController.clear();
    incidentOnChangedLeverSearch('Tất cả');
    incidentOnChangedStatus('Tất cả');
    if (!isRoot) {
      keyDropDownLevel.currentState!.reset();
      keyDropDownStatus.currentState!.reset();
    }
    dateSearchController.clear();
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

  void sendIncident() async {
    Utils.handleUnfocus();
    if (!validator) return;
    isLoadingButton = true;
    final form = <String, dynamic>{
      "title": titleController.text.trim(),
      "date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
      "level": leverText,
      "user_name": nameController.text.trim(),
      "room": roomController.text.trim(),
      "content": contentController.text.trim()
    };
    final res = await api.post('/room-incident', data: form);
    if (res.statusCode == 200 && res.data["code"] == 0) {
      Utils.messSuccess(res.data["message"]);
      await loadDataIncident();
      isLoadingButton = false;
      navKey.currentState!.pop();
      nameController.clear();
      notifyListeners();
    } else {
      Utils.messError(res.data["message"]);
    }
    notifyListeners();
  }
}

final incidentController = ChangeNotifierProvider<IncidentController>(
    (ref) => IncidentController(ref));
