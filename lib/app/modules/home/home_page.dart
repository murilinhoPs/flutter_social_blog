import 'package:challenge_bt_app/app/modules/home/controllers/response_home_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(
          child: Container(
            child: Obx(
              () => Image.network(
                _homeController.userImage.value,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Home page do: ',
        ),
      ),
    );
  }
}
