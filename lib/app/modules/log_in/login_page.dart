import 'package:challenge_bt_app/app/global/controllers/auth_ctrl.dart';
import 'package:challenge_bt_app/app/global/custom/api_consts.dart';
import 'package:challenge_bt_app/app/global/custom/app_colors.dart';
import 'package:challenge_bt_app/app/global/custom_dio/custom_dio.dart';
import 'package:challenge_bt_app/app/global/services/local_db_service.dart';
import 'package:challenge_bt_app/app/global/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  Widget _buttons() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        alignment: Alignment.centerRight,
        height: 70,
        width: double.infinity,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
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
                onPressed: () async {
                  int id = await Get.find<LocalDatabase>().getItem(USERID);

                  Get.find<GlobalDio>().dio.get('/users/$id'); //Get.toNamed('/signup'),
                }),
            SizedBox(
              height: 40,
              child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(horizontal: 40),
                  ),
                ),
                child: Text(
                  'Entrar',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onPressed: () => Get.find<AuthController>()
                    .login({"email": "user2@gmail.com", "password": "senhauser2"}),
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
                    child: InputField(labelText: "Email ou usuário", obscureTxt: false),
                  ),
                  SizedBox(
                    height: 70,
                    width: Get.context.mediaQuerySize.width * 0.85,
                    child: InputField(labelText: "Senha", obscureTxt: true),
                  ),
                ],
              ),
            ),
          ),
          _buttons()
        ],
      ),
    );
  }
}
