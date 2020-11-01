import 'package:challenge_bt_app/app/global/controllers/loading_controller.dart';
import 'package:challenge_bt_app/app/modules/sign_up/controllers/image_select_ctrl.dart';
import 'package:challenge_bt_app/app/modules/sign_up/controllers/signup_validation_ctrl.dart';
import 'package:get/get.dart';

class CreateUserController {
  final _loadingController = Get.find<LoadingController>();
  final _imageSelectCtrl = Get.find<ImageSelectController>();
  final _formController = Get.find<SignupFormController>();

  verifyFieldsToSignup() async {
    _formController.canCheckError.value = true;

    _formController.validateUsername();
    _formController.validateEmail();
    _formController.validatePassword();

    if (_formController.hasError || _imageSelectCtrl.hasErrorValue)
      return _loadingController.setIsLoading(false);

    print('Registrar usuário');

    //TODO: Registrar usuário. Verificar se não tem erro, DioError, se não continua pro login e blabla

    // var authRes = await Get.find<AuthRepository>()
    //     .login({"username": usernameValue, "email": emailValue, "password": passwordValue});

    // if (authRes is DioError) return _loadingController.setIsLoading(false);

    // await _loadingController.getUserInfos();

    // _loadingController.setIsLoading(false);

    // Get.toNamed('/home');
  }
}
