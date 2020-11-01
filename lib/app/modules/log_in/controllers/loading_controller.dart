import 'package:challenge_bt_app/app/global/repositories/user_repository.dart';
import 'package:challenge_bt_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

class LoadingController extends GetxController {
  var isLoading = false.obs;

  setIsLoading(bool value) => isLoading.value = value;

  Future getUserInfos() async {
    var user = await Get.find<UserRepository>().getUser();

    Get.find<ProfileController>().setUserProfile(user);
  }
}
