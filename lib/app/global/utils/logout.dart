import 'package:challenge_bt_app/app/global/services/local_db_service.dart';
import 'package:get/get.dart';

class LogOut {
  static Future logout() async {
    await Get.find<LocalDatabase>().deleteAll();
  }
}
