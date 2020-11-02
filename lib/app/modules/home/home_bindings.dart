import 'package:challenge_bt_app/app/global/controllers/loading_controller.dart';
import 'package:challenge_bt_app/app/modules/home/controllers/check_user_post.dart';
import 'package:challenge_bt_app/app/modules/home/controllers/post_ctrl.dart';
import 'package:challenge_bt_app/app/modules/home/controllers/response_home_ctrl.dart';
import 'package:get/instance_manager.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PostController());
    Get.put(HomeController());
    Get.put(CheckUserPost());
    Get.lazyPut(() => LoadingController(), fenix: true);
  }
}
