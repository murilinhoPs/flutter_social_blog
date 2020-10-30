import 'package:challenge_bt_app/app/global/repositories/http_service_repository.dart';
import 'package:challenge_bt_app/app/global/repositories/user_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var userImage = ''.obs;
  String get userImageValue => userImage.value;

  final _httpRepository = Get.find<HttpServiceRepository>();
  final _userRepository = Get.find<UserRepository>();

  @override
  void onInit() async {
    getUserInfo();

    super.onInit();
  }

  getUserInfo() async {
    final user = await _userRepository.getUser();

    userImage.value = user.image.url;
  }
}
