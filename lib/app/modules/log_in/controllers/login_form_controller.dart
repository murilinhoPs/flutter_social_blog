import 'package:challenge_bt_app/app/global/controllers/auth_ctrl.dart';
import 'package:challenge_bt_app/app/global/utils/check_email.dart';
import 'package:get/get.dart';

import 'loading_controller.dart';

class LoginFormController extends GetxController {
  final _loadingController = Get.find<LoadingController>();

  var userOrEmail = ''.obs;
  String get userOrEmailValue => userOrEmail.value;

  setUserOrEmail(String value) => userOrEmail.value = value;

  var password = ''.obs;
  String get passwordValue => password.value;
  setPassword(String value) => password.value = value;

  var hasError = false;
  setHasError(bool value) => value = value;

  var canCheckError = false.obs;
  bool get canCheckErrorValue => canCheckError.value;
  void clearErrors() => canCheckError.value = false;

  String verifyUser() {
    if ((userOrEmail.value == null || userOrEmail.value.isEmpty) && canCheckErrorValue) {
      setHasError(true);
      return 'O campo é obrigatório';
    }

    setHasError(false);

    return null;
  }

  String verifyPassword() {
    if (canCheckErrorValue) {
      if (passwordValue == null || passwordValue.isEmpty) {
        setHasError(true);

        return 'O campo é obrigatório';
      }

      if (passwordValue.length < 7) {
        setHasError(true);

        return 'Minimo 8 caracteres';
      }
    }

    setHasError(false);

    return null;
  }

  void verifyFieldsToLogin() async {
    canCheckError.value = true;

    verifyUser();
    verifyPassword();

    if (!hasError) {
      if (CheckEmail.isEmail(userOrEmailValue)) {
        _loadingController.setIsLoading(false);

        Get.find<AuthController>().login({"email": userOrEmailValue, "password": passwordValue});

        return;
      }
      // _loadingController.setIsLoading(false);

      Get.find<AuthController>().login({"username": userOrEmailValue, "password": passwordValue});
    }
  }
}
