import 'package:challenge_bt_app/app/global/controllers/loading_controller.dart';
import 'package:challenge_bt_app/app/global/repositories/auth_repository.dart';
import 'package:challenge_bt_app/app/global/repositories/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class LoginFormController extends GetxController {
  final _loadingController = Get.find<LoadingController>();

  var userOrEmail = ''.obs;
  String get userOrEmailValue => userOrEmail.value;

  setUserOrEmail(String value) => userOrEmail.value = value;

  var password = ''.obs;
  String get passwordValue => password.value;
  setPassword(String value) => password.value = value;

  bool hasError = false;
  setHasError(bool value) => hasError = value;

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

      if (passwordValue.length < 8) {
        setHasError(true);

        return 'Minimo 8 caracteres';
      }
    }

    setHasError(false);

    return null;
  }

  verifyFieldsToLogin() async {
    canCheckError.value = true;

    verifyUser();
    verifyPassword();

    if (hasError) return _loadingController.setIsLoading(false);

    if (userOrEmail.value.isEmail) {
      var authRes = await Get.find<AuthRepository>()
          .login({"email": userOrEmailValue, "password": passwordValue});

      if (authRes is DioError) return _loadingController.setIsLoading(false);

      await Get.find<UserRepository>().getUser();

      _loadingController.setIsLoading(false);

      Get.offNamed('/home');

      return;
    }

    var authRes = await Get.find<AuthRepository>()
        .login({"username": userOrEmailValue, "password": passwordValue});

    if (authRes is DioError) return _loadingController.setIsLoading(false);

    await Get.find<UserRepository>().getUser();

    _loadingController.setIsLoading(false);

    Get.offNamed('/home');
  }
}
