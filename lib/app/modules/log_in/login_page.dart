import 'package:challenge_bt_app/app/global/custom/app_colors.dart';
import 'package:challenge_bt_app/app/global/widgets/input_field.dart';
import 'package:challenge_bt_app/app/global/widgets/loading_indicator.dart';
import 'package:challenge_bt_app/app/global/controllers/loading_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import 'controllers/login_form_controller.dart';

class LoginPage extends StatelessWidget {
  final _loginController = Get.put(LoginFormController());
  final _loadingController = Get.find<LoadingController>();

  _onSubmit(context) {
    _loadingController.setIsLoading(true);

    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    _loginController.verifyFieldsToLogin();
  }

  Widget _buttons(context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        alignment: Alignment.centerRight,
        height: 70,
        width: double.infinity,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          border: Border(
            top: BorderSide(
              color: Color(0xFF393e46),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              child: Text(
                'Cadastre-se...',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.lightOrange),
              ),
              onPressed: () => Get.toNamed('/signup'),
            ),
            SizedBox(
              height: 40,
              child: Obx(
                () => ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(horizontal: 30),
                    ),
                  ),
                  child: SizedBox(
                    width: 50,
                    child: _loadingController.isLoading.value
                        ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            height: 20,
                            width: 20,
                            child: LoadingIndicator(
                              color: AlwaysStoppedAnimation<Color>(AppColors.textWhite),
                            ),
                          )
                        : Text(
                            'Entrar',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                  ),
                  onPressed: () => _onSubmit(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 20),
                    child: Text(
                      'Entrar no app',
                      style: TextStyle(
                        color: AppColors.textWhite,
                        fontSize: Get.context.textTheme.headline4.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  SizedBox(
                    height: 80,
                    width: Get.context.mediaQuerySize.width * 0.85,
                    child: Obx(
                      () => InputField(
                        clearError: _loginController.clearErrors,
                        hasError: _loginController.canCheckErrorValue,
                        labelText: "Email ou usuário",
                        obscureTxt: false,
                        onChanged: _loginController.setUserOrEmail,
                        setErrorTxt: _loginController.verifyUser,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    width: Get.context.mediaQuerySize.width * 0.85,
                    child: Obx(
                      () => InputField(
                        clearError: _loginController.clearErrors,
                        hasError: _loginController.canCheckErrorValue,
                        labelText: "Senha",
                        obscureTxt: true,
                        onChanged: _loginController.setPassword,
                        setErrorTxt: _loginController.verifyPassword,
                        submit: (v) => _onSubmit(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buttons(context)
        ],
      ),
    );
  }
}
