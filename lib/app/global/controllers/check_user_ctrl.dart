import 'package:challenge_bt_app/app/global/services/local_db_service.dart';
import 'package:get/get.dart';

class CheckUserController extends GetxController {
  var hasUser = false.obs;

  final localDb = Get.find<LocalDatabase>();

  @override
  void onInit() {
    checkUser();
    super.onInit();
  }

  Future checkUser() async {
    String token = await localDb.getItem("token");

    print(token);

    await Future.delayed(const Duration(seconds: 5));

    if (token != null)
      return Get.offNamed('/home');
    else
      return Get.offNamed('/login');
  }
}
