import 'package:challenge_bt_app/app/global/custom/app_colors.dart';
import 'package:challenge_bt_app/app/modules/home/controllers/response_home_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final _homeController = Get.put(HomeController());

  Widget post(int i) {
    return Container(
      alignment: Alignment.center,
      height: 100,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: Color(0xFF526F9E),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Obx(
              () => Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey,
                ),
                child: Image.network(_homeController.postagensValue[i].post.user.image.url,
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
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(_homeController.postagensValue[i].post.content),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('Home page');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.purple,
        elevation: 0.0,
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
            onPressed: () => Get.offNamed('/login'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: Obx(
          () => ListView.builder(
            itemCount: _homeController.postagensValue.length,
            itemBuilder: (context, i) => post(i),
          ),
        ),
      ),
    );
  }
}
