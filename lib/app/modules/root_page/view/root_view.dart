import 'package:boarding_group/app/modules/root_page/controller/root_controller.dart';
import 'package:boarding_group/app/modules/root_page/view/components/widget/custom_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../common/config.dart';
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
    );
  }
}

final _controller =
    ChangeNotifierProvider<RootController>((ref) => RootController());

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