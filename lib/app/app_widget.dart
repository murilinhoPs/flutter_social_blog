import 'package:challenge_bt_app/app/global/controllers/http_service_state_ctrl.dart';
import 'package:challenge_bt_app/app/global/repositories/custom_dio.dart';
import 'package:challenge_bt_app/app/global/services/local_db_service.dart';
import 'package:challenge_bt_app/app/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppWidget extends StatelessWidget {
  final dioGlobal = Get.lazyPut<GlobalDio>(() => GlobalDio());
  final localDb = Get.lazyPut<LocalDatabase>(() => LocalDatabase());
  final httpController = Get.put(HttpServiceController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Challenge',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      getPages: AppRoutes.routes,
    );
  }
}
