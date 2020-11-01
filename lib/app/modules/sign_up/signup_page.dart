import 'package:challenge_bt_app/app/global/custom/app_colors.dart';
import 'package:challenge_bt_app/app/modules/sign_up/controllers/image_select_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';

class SignupPage extends StatelessWidget {
  final _imageSelectCtrl = Get.put(ImageSelectController());

  onSubmit(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

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
                'Já tem conta?',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.lightOrange),
              ),
              onPressed: () => Get.offNamed('/login'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
              child: SizedBox(
                width: 80,
                child: Text(
                  'Cadastrar',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => navigator.pop(),
          color: AppColors.textWhite,
          iconSize: 30.0,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Crie sua Conta',
                      style: TextStyle(
                        color: AppColors.textWhite,
                        fontSize: Get.context.textTheme.headline4.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  // SizedBox(
                  //   height: 80,
                  //   width: Get.context.mediaQuerySize.width * 0.85,
                  //   child: InputField(labelText: "Nome de usuário", obscureTxt: false),
                  // ),
                  // SizedBox(
                  //   height: 80,
                  //   width: Get.context.mediaQuerySize.width * 0.85,
                  //   child: InputField(labelText: "Email", obscureTxt: false),
                  // ),
                  // SizedBox(
                  //   height: 70,
                  //   width: Get.context.mediaQuerySize.width * 0.85,
                  //   child: InputField(labelText: "Senha", obscureTxt: true),
                  // ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Obx(
                          () => !_imageSelectCtrl.hasImageValue
                              ? Text('Escolha uma imagem ...')
                              : Image.file(
                                  _imageSelectCtrl.imageValue,
                                  height: Get.context.mediaQuerySize.height * 0.25,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 140,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(horizontal: 20),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Imagem: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                FontAwesome.angle_down,
                                size: 26.0,
                              ),
                            ],
                          ),
                          onPressed: () async => await _imageSelectCtrl.getImage(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Text('vai ser o error text da imagem ao subir'),
                      )
                    ],
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
