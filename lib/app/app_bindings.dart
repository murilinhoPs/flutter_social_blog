import 'package:challenge_bt_app/app/global/controllers/http_service_state_ctrl.dart';
import 'package:challenge_bt_app/app/global/controllers/nav_rail_ctrl.dart';
import 'package:challenge_bt_app/app/global/custom_dio/custom_dio.dart';
import 'package:challenge_bt_app/app/global/repositories/auth_repository.dart';
import 'package:challenge_bt_app/app/global/repositories/http_service_repository.dart';
import 'package:challenge_bt_app/app/global/repositories/user_repository.dart';
import 'package:challenge_bt_app/app/global/services/local_db_service.dart';
import 'package:challenge_bt_app/app/global/controllers/loading_controller.dart';
import 'package:challenge_bt_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HttpServiceController());
    Get.lazyPut(() => HttpServiceRepository());
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => GlobalDio());
    Get.put(LoadingController());
    Get.put(NavRailController());
    Get.put(LocalDatabase());
    Get.put(AuthRepository());
    Get.put(UserRepository());
  }
}
