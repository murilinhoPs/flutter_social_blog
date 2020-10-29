import 'package:challenge_bt_app/app/global/controllers/check_user_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckUser extends StatelessWidget {
  final _checkUserController = Get.put(CheckUserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
        ),
      ),
    );
  }
}
