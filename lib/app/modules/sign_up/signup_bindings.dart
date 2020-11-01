import 'package:challenge_bt_app/app/modules/sign_up/controllers/create_user_ctrl.dart';
import 'package:challenge_bt_app/app/modules/sign_up/controllers/image_select_ctrl.dart';
import 'package:challenge_bt_app/app/modules/sign_up/controllers/signup_validation_ctrl.dart';
import 'package:get/instance_manager.dart';

class SignupBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignupFormController());
    Get.lazyPut(() => CreateUserController());
    Get.put(ImageSelectController());
  }
}
