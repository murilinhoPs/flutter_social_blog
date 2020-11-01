import 'package:challenge_bt_app/app/global/custom/api_consts.dart';
import 'package:challenge_bt_app/app/global/models/all_posts.dart';
import 'package:challenge_bt_app/app/global/models/user_model.dart';
import 'package:challenge_bt_app/app/global/services/local_db_service.dart';
import 'package:challenge_bt_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

import 'http_service_repository.dart';

class UserRepository {
  final _httpRepository = Get.find<HttpServiceRepository>();
  final localDb = Get.find<LocalDatabase>();
  int id;

  Future<UserModel> getUser() async {
    id = await Get.find<LocalDatabase>().getItem(USERID);

    var response = await _httpRepository.get('/users/$id');

    UserModel user = UserModel.fromJson(response);

    Get.find<ProfileController>().setUserProfile(user);

    return user;
  }

  Future<List<AllPostsModel>> getAllPosts() async {
    var _response = await _httpRepository.get('/posts');

    List<dynamic> newResponse = _response;

    print("GetAllPosts: $newResponse");

    List<AllPostsModel> allPostsList = newResponse.map((v) => AllPostsModel.fromJson(v)).toList();

    return allPostsList;
  }
}
