import 'package:challenge_bt_app/app/modules/home/controllers/check_user_post.dart';
import 'package:challenge_bt_app/app/modules/home/controllers/response_home_ctrl.dart';
import 'package:get/instance_manager.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(CheckUserPost());
  }
}
