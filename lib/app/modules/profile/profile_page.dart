import 'package:challenge_bt_app/app/global/custom/app_colors.dart';
import 'package:challenge_bt_app/app/global/widgets/nav_rail.dart';
import 'package:challenge_bt_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  final _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Get.toNamed('/'),
            child: Obx(
              () => CircleAvatar(
                backgroundImage:
                    NetworkImage(_profileController.userProfileValue.image.url, scale: 1.0),
              ),
            ),
          ),
        ),
      ),
      body: Row(
        children: [
          CustomNavigationRails(),
          VerticalDivider(
            thickness: 1.5,
            width: 1.5,
            color: AppColors.blue,
          ),
          Expanded(
            child: Obx(
              () => Padding(
                padding: EdgeInsets.all(11.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Username: ' +
                            _profileController.userProfileValue.username +
                            '\n' +
                            ' Id no banco de dados: ' +
                            _profileController.userProfileValue.id.toString(),
                      ),
                      TextSpan(text: '\n'),
                      TextSpan(text: '\n' + 'Email: ' + _profileController.userProfileValue.email),
                      TextSpan(text: '\n'),
                      TextSpan(
                        text: '\n' + 'Bio: ' + _profileController.userProfileValue.bio.content,
                      ),
                      TextSpan(text: '\n'),
                      TextSpan(
                        text: '\n' +
                            'Apenas uma página que pega as informações do perfil do usuário logado.' +
                            '\n' +
                            'Em breve poderá editar seu perfil e aparecerá suas postagens' +
                            '\n' +
                            'Eu implementei no back-end essa função de editar perfil',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
