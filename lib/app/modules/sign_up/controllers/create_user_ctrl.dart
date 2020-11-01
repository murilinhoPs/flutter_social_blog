import 'dart:io';

import 'package:challenge_bt_app/app/global/controllers/loading_controller.dart';
import 'package:challenge_bt_app/app/global/repositories/auth_repository.dart';
import 'package:challenge_bt_app/app/global/repositories/user_repository.dart';
import 'package:challenge_bt_app/app/modules/sign_up/controllers/image_select_ctrl.dart';
import 'package:challenge_bt_app/app/modules/sign_up/controllers/signup_validation_ctrl.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class CreateUserController {
  final _loadingController = Get.find<LoadingController>();
  final _imageSelectCtrl = Get.find<ImageSelectController>();
  final _formController = Get.find<SignupFormController>();

  var formData = FormData().obs;
  FormData get formDataValue => formData.value;
  void setFormData(FormData form) => formData.value = form;

  verifyFieldsToSignup() async {
    _loadingController.setIsLoading(true);

    _formController.canCheckError.value = true;

    _formController.validateUsername();
    _formController.validateEmail();
    _formController.validatePassword();

    if (_imageSelectCtrl.imageValue.toString() == "File: ''") {
      _imageSelectCtrl.setErrorText('Imagem não pode ser vazia');

      _imageSelectCtrl.setHasError(true);
    }

    if (_formController.hasError || _imageSelectCtrl.hasErrorValue)
      return _loadingController.setIsLoading(false);

    final imageName = _imageSelectCtrl.imageValue.path.split('/').last;

    setFormData(FormData.fromMap({
      "username": _formController.usernameValue,
      "password": _formController.passwordValue,
      "email": _formController.emailValue,
      "image": await MultipartFile.fromFile(_imageSelectCtrl.imageValue.path, filename: imageName)
    }));

    String username = formDataValue.fields[0].value;
    String password = formDataValue.fields[1].value;

    var createUserRes = await Get.find<AuthRepository>().signup(formDataValue);

    if (createUserRes is DioError) return _loadingController.setIsLoading(false);

    var authRes =
        await Get.find<AuthRepository>().login({"username": username, "password": password});

    if (authRes is DioError) return _loadingController.setIsLoading(false);

    await Get.find<UserRepository>().getUser();

    _loadingController.setIsLoading(false);

    Get.toNamed('/home');
  }
}
