import 'package:challenge_bt_app/app/global/widgets/loading_indicator.dart';
import 'package:challenge_bt_app/app/global/widgets/nav_rail.dart';
import 'package:challenge_bt_app/app/modules/home/controllers/post_ctrl.dart';
import 'package:challenge_bt_app/app/modules/home/controllers/response_home_ctrl.dart';
import 'package:challenge_bt_app/app/modules/home/controllers/check_user_post.dart';
import 'package:challenge_bt_app/app/modules/home/widgets/post_dialog.dart';
import 'package:challenge_bt_app/app/global/custom/app_colors.dart';
import 'package:challenge_bt_app/app/global/utils/logout.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final _homeController = Get.find<HomeController>();
  final _checkUserPost = Get.find<CheckUserPost>();

  Widget post(int i) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: AppColors.blue,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Obx(
              () => CircleAvatar(
                backgroundImage: NetworkImage(
                    _homeController.postagensValue[i].post.user.image.path,
                    scale: 2.0),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '@' + _homeController.postagensValue[i].post.user.username,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  SelectableText(_homeController.postagensValue[i].post.content),
                ],
              ),
            ),
          ),
          Obx(
            () => _checkUserPost.canEdit(_homeController.postagensValue[i].post.id)
                ? _checkUserPost.checkUserWidget(_homeController.postagensValue[i].post)
                : Container(),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Get.toNamed('/profile'),
            child: Obx(
              () => CircleAvatar(
                backgroundImage: NetworkImage(_homeController.userImage.value, scale: 1.0),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              FontAwesome.logout,
              color: AppColors.textLightOrange,
              size: 28.0,
            ),
            onPressed: () => LogOut.logout().then((value) => Get.offNamed('/login')),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(FontAwesome.pencil),
          onPressed: () {
            Get.find<PostController>().setMethod(EnumMethod.POST);

            Get.to(
              PostDialog(),
              transition: Transition.downToUp,
              arguments: [_homeController.userImageValue, 0],
            );
          }),
      // bottomNavigationBar: BottomNavigationBar(items: [BottomNavigationBarItem()],),
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          CustomNavigationRails(),
          VerticalDivider(
            thickness: 1.5,
            width: 1.5,
            color: AppColors.blue,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => _homeController.getPosts(),
              child: Obx(
                () => ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.only(bottom: 40),
                  itemCount: _homeController.postagensValue.length,
                  itemBuilder: (context, i) =>
                      _homeController.postagensValue.isNull ? LoadingIndicator() : post(i),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
