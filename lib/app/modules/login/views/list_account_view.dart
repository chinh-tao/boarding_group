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
      ref.read(_controller.notifier).initData(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: BodyListAccount(controller: _controller),
      floatingActionButton: const CustomMenu(),
    );
  }
}

final _controller = ChangeNotifierProvider<ListAccountController>(
    (ref) => ListAccountController());
