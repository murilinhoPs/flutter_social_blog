import 'package:challenge_bt_app/app/global/models/user_model.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var userProfile = UserModel().obs;
  UserModel get userProfileValue => userProfile.value;

  void setUserProfile(UserModel user) => userProfile.value = user;
}
