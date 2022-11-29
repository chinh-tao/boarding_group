import 'package:boarding_group/app/common/global.dart';
import 'package:boarding_group/app/modules/bill/controller/bill_controller.dart';
import 'package:boarding_group/app/modules/root_page/controller/root_controller.dart';
import 'package:boarding_group/app/modules/root_page/view/components/widget/custom_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../../common/config.dart';
import '../../../routes/app_pages.dart';
import '../../bill/view/list_bill_view.dart';
import '../../home/views/home_view.dart';
import '../../incident/view/list_incident_view.dart';
import '../../service/view/service_view.dart';

class RootView extends ConsumerWidget {
  const RootView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
      ),
      drawer: CustomDrawer(controller: _controller),
      body: ref.watch(page),
      floatingActionButton: ref.watch(actionButton),
    );
  }
}

final _controller =
    ChangeNotifierProvider<RootController>((ref) => RootController());

final billController =
    ChangeNotifierProvider<BillController>((ref) => BillController());

final page = Provider<Widget>((ref) {
  switch (ref.watch(_controller).index) {
    case 1:
      return const ListBillView();
    case 2:
      return const ListIncidentView();
    case 3:
      return const ServiceView();
    default:
      return const HomeView();
  }
});

final actionButton = Provider<Widget?>((ref) {
  if (ref.watch(_controller).index == 0) {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: kPrimaryColor,
      child: const Icon(Icons.filter_list_alt),
    );
  } else if (ref.watch(_controller).index == 1) {
    return FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          ref.watch(billController).showMonth(ref);
        },
        child: const Icon(Icons.calendar_month_sharp));
  } else if (ref.watch(_controller).index == 2) {
    return FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () =>
            Navigator.of(navKey.currentContext!).pushNamed(Routes.ADD_INCIDENT),
        child: const Icon(Icons.add));
  }
  return null;
});
