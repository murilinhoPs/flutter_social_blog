import 'package:challenge_bt_app/app/global/widgets/check_user.dart';
import 'package:challenge_bt_app/app/modules/home/home_bindings.dart';
import 'package:challenge_bt_app/app/modules/home/home_page.dart';
import 'package:challenge_bt_app/app/modules/last_news/last_news_page.dart';
import 'package:challenge_bt_app/app/modules/log_in/login_page.dart';
import 'package:challenge_bt_app/app/modules/profile/profile_page.dart';
import 'package:challenge_bt_app/app/modules/sign_up/signup_bindings.dart';
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
      binding: SignupBindings(),
    ),
    GetPage(
      name: '/home',
      page: () => HomePage(),
      transition: pageTransition,
      binding: HomeBindings(),
    ),
    GetPage(
      name: '/profile',
      page: () => ProfilePage(),
      transition: pageTransition,
    ),
    GetPage(
      name: '/news',
      page: () => NewsPage(),
      transition: pageTransition,
    ),
  ];
}
