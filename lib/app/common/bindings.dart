import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../modules/home/controllers/home_controller.dart';

class Bindings {
  late final homeController =
      ChangeNotifierProvider<HomeController>((ref) => HomeController());
}
