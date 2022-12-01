import 'package:boarding_group/app/common/config.dart';
import 'package:boarding_group/app/modules/login/controllers/list_account_controller.dart';
import 'package:boarding_group/app/modules/login/views/body/body_list_account.dart';
import 'package:boarding_group/app/modules/login/views/body/custom_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListAccountView extends ConsumerStatefulWidget {
  const ListAccountView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListAccountViewState();
}

class _ListAccountViewState extends ConsumerState<ListAccountView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(listAccountController.notifier).initData(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: ref.watch(showContent),
      floatingActionButton: const CustomMenu(),
    );
  }
}

final showContent = Provider<Widget>((ref) {
  if (ref.watch(listAccountController).isLoading) {
    return const Center(
        child: Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(color: Colors.white)));
  }
  return const BodyListAccount();
});
