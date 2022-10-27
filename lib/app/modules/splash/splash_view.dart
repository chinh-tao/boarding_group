import 'package:boarding_group/app/modules/auth/auth_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../common/config.dart';
import '../../common/primary_style.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 2), vsync: this)
        ..repeat(reverse: false);
  late final Animation<double> animation =
      CurvedAnimation(parent: _controller, curve: Curves.easeOutQuint);
  final AuthController authController = Get.find();

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          alignment: Alignment.center,
          child: RotationTransition(
            turns: animation,
            child: Image.asset('assets/images/logo.png', height: 300),
          ),
        ),
        const SizedBox(height: 20),
        Text("Boarding Group",
            textAlign: TextAlign.center,
            style: PrimaryStyle.bold(52, color: kPrimaryColor))
      ]),
    );
  }

  void initData() async {
    await authController.checkDevice();
  }
}
