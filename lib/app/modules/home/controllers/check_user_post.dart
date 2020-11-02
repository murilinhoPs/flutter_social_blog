import 'package:challenge_bt_app/app/global/custom/api_consts.dart';
import 'package:challenge_bt_app/app/global/models/all_posts.dart';
import 'package:challenge_bt_app/app/global/services/local_db_service.dart';
import 'package:challenge_bt_app/app/modules/home/controllers/post_ctrl.dart';
import 'package:challenge_bt_app/app/modules/home/controllers/response_home_ctrl.dart';
import 'package:challenge_bt_app/app/modules/home/widgets/post_dialog.dart';
import 'package:challenge_bt_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';

class CheckUserPost extends GetxController {
  final _postController = Get.find<PostController>();

  var localDbId = 0.obs;
  int get localDbIdValue => localDbId.value;

  @override
  void onInit() async {
    localDbId.value = await Get.find<LocalDatabase>().getItem(USERID);

    super.onInit();
  }

  bool canEdit(int id) {
    var postIdList =
        Get.find<ProfileController>().userProfileValue.posts.map((post) => post.post.id).toList();

    if (postIdList.contains(id)) return true;

    return false;
  }

  Widget checkUserWidget(PostFromAll post) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: IconButton(
        splashRadius: 1.0,
        icon: Icon(FontAwesome.edit),
        onPressed: () {
          _postController.setMethod(EnumMethod.PUT);

          _postController.setPostContent(post.content);

          print(_postController.postContentValue);

          Get.to(
            PostDialog(),
            transition: Transition.downToUp,
            arguments: [Get.find<HomeController>().userImageValue, post.id],
          );
        },
      ),
    );
  }
}
