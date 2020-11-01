import 'package:challenge_bt_app/app/global/custom/api_consts.dart';
import 'package:challenge_bt_app/app/global/repositories/user_repository.dart';
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
    String token = await localDb.getItem(ACCESSTOKEN);
    String refreshToken = await localDb.getItem(REFRESHTOKEN);
    int id = await localDb.getItem(USERID);

    await Future.delayed(const Duration(seconds: 3));

    if (token != null) {
      print(token + ' refresh: ' + refreshToken + ' ->  ' + id.toString());

      await Get.find<UserRepository>().getUser();

      return Get.offNamed('/home');
    } else
      return Get.offNamed('/login');
  }
}
