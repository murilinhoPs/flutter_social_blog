import 'package:challenge_bt_app/app/global/models/all_posts.dart';
import 'package:challenge_bt_app/app/global/repositories/user_repository.dart';
import 'package:challenge_bt_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _userRepository = Get.find<UserRepository>();
  final _profileController = Get.find<ProfileController>();

  var userImage = ''.obs;
  String get userImageValue => userImage.value;

  var postagens = List<AllPostsModel>().obs;
  List<AllPostsModel> get postagensValue => postagens;
  void setPostagens(List<AllPostsModel> value) => postagens.value = value;

  @override
  void onInit() {
    getUserInfo();

    getPosts();

    super.onInit();
  }

  getUserInfo() {
    final user = _profileController.userProfileValue;

    userImage.value = user.image.url;
  }

  getPosts() async {
    await Get.find<UserRepository>().getUser();

    var postsList = await _userRepository.getAllPosts();

    setPostagens(postsList);
  }
}
