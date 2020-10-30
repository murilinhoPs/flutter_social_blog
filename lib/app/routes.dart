import 'package:challenge_bt_app/app/global/widgets/check_user.dart';
import 'package:challenge_bt_app/app/modules/home/home_page.dart';
import 'package:challenge_bt_app/app/modules/log_in/login_page.dart';
import 'package:challenge_bt_app/app/modules/sign_up/signup_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/route_manager.dart';

class AppRoutes {
  static final pageTransition = Transition.cupertino;

  static final routes = [
    GetPage(
      name: '/',
      page: () => CheckUser(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginPage(),
      transition: pageTransition,
    ),
    GetPage(
      name: '/signup',
      page: () => SignupPage(),
      transition: pageTransition,
    ),
    GetPage(
      name: '/home',
      page: () => HomePage(),
      transition: pageTransition,
    )
  ];
}
