import 'package:challenge_bt_app/app/global/custom/api_consts.dart';
import 'package:challenge_bt_app/app/global/models/user_model.dart';
import 'package:challenge_bt_app/app/global/services/local_db_service.dart';
import 'package:get/get.dart';

import 'http_service_repository.dart';

class UserRepository {
  final _httpRepository = Get.find<HttpServiceRepository>();
  final localDb = Get.find<LocalDatabase>();

  Future<UserModel> getUser() async {
    int id = await Get.find<LocalDatabase>().getItem(USERID);

    var response = await _httpRepository.get('/users/$id');

    UserModel userModel = UserModel.fromJson(response);

    return userModel;
  }
}
