import 'package:get/state_manager.dart';

class LoginFormController extends GetxController {
  var userOrEmail = ''.obs;
  void setUserOrEmail(String value) => userOrEmail.value = value;

  var password = ''.obs;
  void setPassword(String value) => password.value = value;

  var obscuredText = true.obs;
  void setObscuredText() => obscuredText.value = !obscuredText.value;
}
