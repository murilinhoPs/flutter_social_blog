import 'package:challenge_bt_app/app/global/controllers/http_service_state_ctrl.dart';
import 'package:challenge_bt_app/app/global/custom/api_consts.dart';
import 'package:challenge_bt_app/app/global/services/local_db_service.dart';
import 'package:challenge_bt_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';

class CheckUserPost extends GetxController {
  final _profileController = Get.find<ProfileController>();

  var localDbId = 0.obs;
  int get localDbIdValue => localDbId.value;

  @override
  void onInit() async {
    localDbId.value = await Get.find<LocalDatabase>().getItem(USERID);

    super.onInit();
  }

  bool canEdit(int id) {
    var postIdList = _profileController.userProfileValue.posts.map((post) => post.post.id).toList();

    if (postIdList.contains(id)) return true;

    return false;
  }

  Widget checkUserWidget(int id) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: IconButton(
        splashRadius: 1.0,
        icon: Icon(FontAwesome.edit),
        onPressed: () => Get.find<HttpServiceController>()
            .showWarning(mensagem: 'Você pode editar o post de id: $id', title: 'Sua postagem!'),
      ),
    );
  }
}
