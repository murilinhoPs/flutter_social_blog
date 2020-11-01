import 'package:challenge_bt_app/app/app_bindings.dart';
import 'package:challenge_bt_app/app/global/custom/theme_data.dart';
import 'package:challenge_bt_app/app/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Challenge',
      enableLog: true,
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.customTheme,
      initialRoute: '/',
      getPages: AppRoutes.routes,
      initialBinding: AppBindings(),
    );
  }
}
