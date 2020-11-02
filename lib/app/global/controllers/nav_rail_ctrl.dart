import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NavRailController extends GetxController {
  var selectedIndex = 0.obs;
  int get selectedIndexValue => selectedIndex.value;
  void setSelectedIndex(int index) => selectedIndex.value = index;

  void goTo(int index) {
    setSelectedIndex(index);

    if (selectedIndexValue == 0) if (Get.currentRoute != '/home') Get.toNamed('/home');

    if (selectedIndexValue == 1) if (Get.currentRoute != '/news') Get.toNamed('/news');

    if (selectedIndexValue == 2) if (Get.currentRoute != '/profile') Get.toNamed('/profile');
  }
}
