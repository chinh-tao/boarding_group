import 'package:get/get.dart';

import '../modules/auth/auth_binding.dart';
import '../modules/change_pass/bindings/change_pass_binding.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/list_account_binding.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/list_account_view.dart';
import '../modules/login/views/login_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/splash/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
        name: _Paths.HOME,
        page: () => const HomeView(),
        binding: HomeBinding()),
    GetPage(
        name: _Paths.LOGIN,
        page: () => const LoginView(),
        binding: LoginBinding()),
    GetPage(
        name: _Paths.REGISTER,
        page: () => const RegisterView(),
        binding: RegisterBinding()),
    GetPage(
        name: _Paths.SPLASH,
        page: () => const SplashView(),
        binding: AuthBinding()),
    GetPage(
        name: _Paths.LIST_ACCOUNT,
        page: () => const ListAccountView(),
        binding: ListAccountBinding(),
        bindings: [ChangePassBinding()]),
  ];
}
