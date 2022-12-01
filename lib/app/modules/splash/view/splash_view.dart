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
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(splashController.notifier).checkDevice(ref);
    });
    super.initState();
  }

  @override
  void dispose() {
    ref.watch(_animationController(this)).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          alignment: Alignment.center,
          child: RotationTransition(
            turns: ref.watch(_animation(this)),
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

final _animationController =
    Provider.family<AnimationController, TickerProvider>((ref, ticker) =>
        AnimationController(duration: const Duration(seconds: 2), vsync: ticker)
          ..repeat(reverse: false));
final _animation = Provider.family<Animation<double>, TickerProvider>(
    (ref, ticker) => CurvedAnimation(
        parent: ref.watch(_animationController(ticker)),
        curve: Curves.easeOutQuint));
