import 'package:boarding_group/app/common/global.dart';
import 'package:boarding_group/app/modules/root_page/controller/root_controller.dart';
import 'package:boarding_group/app/modules/root_page/view/components/widget/custom_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../../common/config.dart';
import '../../../routes/app_pages.dart';
import '../../bill/view/list_bill_view.dart';
import '../../home/views/home_view.dart';
import '../../incident/view/components/search_incident.dart';
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
        actions: ref.watch(action) != null ? [ref.watch(action)!] : [],
      ),
      drawer: CustomDrawer(controller: rootController),
      endDrawer: ref.watch(endDrawer),
      body: ref.watch(page),
      floatingActionButton: ref.watch(actionButton),
    );
  }
}

final page = Provider<Widget>((ref) {
  switch (ref.watch(rootController).index) {
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
  if (ref.watch(rootController).index == 0) {
    return FloatingActionButton(
      onPressed: () => ref.read(rootController.notifier).showSearchView(),
      backgroundColor: kPrimaryColor,
      child: const Icon(Icons.filter_list_alt),
    );
  } else if (ref.watch(rootController).index == 1) {
    return FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () => ref.read(rootController.notifier).showSearchBillView(),
        child: const Icon(Icons.calendar_month_sharp));
  } else if (ref.watch(rootController).index == 2) {
    return FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () => navKey.currentState!.pushNamed(Routes.ADD_INCIDENT),
        child: const Icon(Icons.add));
  }
  return null;
});

final endDrawer = Provider<Widget?>((ref) {
  if (ref.watch(rootController).index == 2) {
    return const SearchIncident();
  }
  return null;
});

final action = Provider<Widget?>((ref) {
  if (ref.watch(rootController).index == 0) {
    return IconButton(
        onPressed: () => navKey.currentState!.pushNamed(Routes.NOTIFICATION),
        icon: const Icon(Icons.notifications_sharp));
  } else if (ref.watch(rootController).index == 2) {
    return Builder(
        builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openEndDrawer(),
            icon: const Icon(Icons.filter_list_alt, size: 20)));
  }
  return null;
});
