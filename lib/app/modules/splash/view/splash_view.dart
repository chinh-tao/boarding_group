import 'package:boarding_group/app/modules/splash/controller/spalsh_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/config.dart';
import '../../../common/primary_style.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>
    with TickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(duration: const Duration(seconds: 2), vsync: this)
        ..repeat(reverse: false);
  late final Animation<double> animation =
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutQuint);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(_controller.notifier).initData(context, ref);
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
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
}

final _controller =
    ChangeNotifierProvider<SplashController>((ref) => SplashController());
