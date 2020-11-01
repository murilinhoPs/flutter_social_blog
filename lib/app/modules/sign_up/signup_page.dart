import 'package:challenge_bt_app/app/global/controllers/http_service_state_ctrl.dart';
import 'package:challenge_bt_app/app/global/custom/app_colors.dart';
import 'package:challenge_bt_app/app/global/widgets/input_field.dart';
import 'package:challenge_bt_app/app/modules/sign_up/controllers/image_select_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignupPage extends StatelessWidget {
  final _imageSelectCtrl = Get.put(ImageSelectController());
  final _imagePicker = ImagePicker();

  Future _getImage() async {
    var image = await _imagePicker.getImage(source: ImageSource.gallery);

    if (image != null)
      return image;
    else
      Get.find<HttpServiceController>().showWarning(mensagem: 'Nenhuma imagem selecionada');
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
            Column(
              children: [
                Obx(
                  () => _imageSelectCtrl.imageValue == null
                      ? Text('Escolha uma imagem ...')
                      : Image.file(
                          _imageSelectCtrl.imageValue,
                          width: 60,
                          height: 60,
                          fit: BoxFit.fitHeight,
                        ),
                ),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(horizontal: 40),
                      ),
                    ),
                    child: Text(
                      'Cadastrar',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      var selectedImage = await _getImage();

                      _imageSelectCtrl.setImage(selectedImage);
                    },
                  ),
                ),
                Text('vai ser o error text da imagem ao subir')
              ],
            ),
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
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'Crie sua Conta',
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
                    child: InputField(labelText: "Nome de usuário", obscureTxt: false),
                  ),
                  SizedBox(
                    height: 80,
                    width: Get.context.mediaQuerySize.width * 0.85,
                    child: InputField(labelText: "Email", obscureTxt: false),
                  ),
                  SizedBox(
                    height: 70,
                    width: Get.context.mediaQuerySize.width * 0.85,
                    child: InputField(labelText: "Senha", obscureTxt: true),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    width: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(horizontal: 40),
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
                      onPressed: () {},
                    ),
                  )
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
