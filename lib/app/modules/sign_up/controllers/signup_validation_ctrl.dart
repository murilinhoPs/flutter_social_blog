import 'package:get/get.dart';

class SignupFormController extends GetxController {
  var username = ''.obs;
  String get usernameValue => username.value;
  void setUsername(String value) => username.value = value;

  var password = ''.obs;
  String get passwordValue => password.value;
  void setPassword(String value) => password.value = value;

  var email = ''.obs;
  String get emailValue => email.value;
  void setEmail(String value) => email.value = value;

  bool hasError = false;
  setHasError(bool value) => hasError = value;

  var canCheckError = false.obs;
  bool get canCheckErrorValue => canCheckError.value;
  void clearErrors() => canCheckError.value = false;

  String validateUsername() {
    if ((username.value == null || username.value.isEmpty) && canCheckErrorValue) {
      setHasError(true);
      return 'O campo é obrigatório';
    }

    setHasError(false);

    return null;
  }

  String validateEmail() {
    if (canCheckErrorValue) {
      if (emailValue == null || emailValue.isEmpty) {
        setHasError(true);

        return 'O campo é obrigatório';
      }

      if (!emailValue.isEmail) {
        setHasError(true);

        return 'Digite um email válido';
      }
    }

    setHasError(false);

    return null;
  }

  String validatePassword() {
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
}
