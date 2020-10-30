import 'package:challenge_bt_app/app/global/controllers/auth_ctrl.dart';
import 'package:challenge_bt_app/app/global/controllers/http_service_state_ctrl.dart';
import 'package:challenge_bt_app/app/global/custom/theme_data.dart';
import 'package:challenge_bt_app/app/global/custom_dio/custom_dio.dart';
import 'package:challenge_bt_app/app/global/repositories/http_service_repository.dart';
import 'package:challenge_bt_app/app/global/services/local_db_service.dart';
import 'package:challenge_bt_app/app/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'global/repositories/user_repository.dart';

class AppWidget extends StatelessWidget {
  final localDb = Get.put(LocalDatabase()); //Get.lazyPut<LocalDatabase>(() => LocalDatabase());
  final globalDio = Get.put(GlobalDio());
  final httpController = Get.put(HttpServiceController());
  final httpService = Get.put(HttpServiceRepository());
  final authController = Get.put(AuthController());
  final userRepository = Get.put(UserRepository());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Challenge',
      theme: CustomTheme.customTheme,
      initialRoute: '/',
      getPages: AppRoutes.routes,
    );
  }
}
