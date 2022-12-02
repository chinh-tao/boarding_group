import 'package:boarding_group/app/modules/bill/view/detail_bill_view.dart';
import 'package:boarding_group/app/modules/bill/view/list_bill_view.dart';
import 'package:boarding_group/app/modules/home/views/components/body/detail_member_view.dart';
import 'package:boarding_group/app/modules/incident/view/add_incident_view.dart';
import 'package:boarding_group/app/modules/incident/view/incident_detail.dart';
import 'package:boarding_group/app/modules/incident/view/list_incident_view.dart';
import 'package:boarding_group/app/modules/notification/view/notice_view.dart';
import 'package:boarding_group/app/modules/root_page/view/root_view.dart';
import 'package:boarding_group/app/modules/service/view/service_view.dart';
import 'package:boarding_group/app/modules/user/view/user_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/views/list_account_view.dart';
import '../modules/login/views/login_view.dart';
import '../modules/register/views/register_view.dart';
import '../modules/splash/view/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = {
    Routes.SPLASH: (_) => const SplashView(),
    Routes.LOGIN: (_) => const LoginView(),
    Routes.REGISTER: (_) => const RegisterView(),
    Routes.LIST_ACCOUNT: (_) => const ListAccountView(),
    Routes.HOME: (_) => const HomeView(),
    Routes.NOTIFICATION: (_) => const NoticeView(),
    Routes.LIST_BILL: (_) => const ListBillView(),
    Routes.DETAIL_BILL: (_) => const DetailBillView(),
    Routes.LIST_INCIDENT: (_) => const ListIncidentView(),
    Routes.ADD_INCIDENT: (_) => const AddIncidentView(),
    Routes.INCIDENTDETAIL: (_) => const IncidentDetail(),
    Routes.USER: (_) => const UserView(),
    Routes.DETAIL_MEMBER: (_) => const DetailMemberView(),
    Routes.ROOT: (_) => const RootView(),
    Routes.SERVICE: (_) => const ServiceView()
  };
}
