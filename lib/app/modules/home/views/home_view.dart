import 'package:boarding_group/app/common/config.dart';
import 'package:boarding_group/app/common/primary_style.dart';
import 'package:boarding_group/app/modules/home/controllers/home_controller.dart';
import 'package:boarding_group/app/modules/home/views/components/body/list_member.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(homeController.notifier).initData(ref);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async =>
          ref.read(homeController.notifier).getListMember(ref, isRefresh: true),
      backgroundColor: kPrimaryColor,
      color: kWhiteColor,
      child: ref.watch(showListMember),
    );
  }

  Widget item(String title, String content) {
    return Row(
      children: [
        Text(title, style: PrimaryStyle.bold(20, color: kRedColor400)),
        const SizedBox(width: 4),
        Text(content, style: PrimaryStyle.normal(20, color: kRedColor400))
      ],
    );
  }
}

final showListMember = Provider<Widget>((ref) {
  if (ref.watch(homeController).isLoading) {
    return const Center(
      child: CircularProgressIndicator(color: kIndigoBlueColor900),
    );
  } else {
    return ListMember(listMember: ref.watch(homeController).listMember);
  }
});
