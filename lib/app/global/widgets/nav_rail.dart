import 'package:challenge_bt_app/app/global/controllers/nav_rail_ctrl.dart';
import 'package:challenge_bt_app/app/global/custom/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';

class CustomNavigationRails extends StatelessWidget {
  final _navRailCtrl = Get.find<NavRailController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => NavigationRail(
        backgroundColor: AppColors.backgroundColor,
        minWidth: 40,
        elevation: 10.0,
        selectedIndex: _navRailCtrl.selectedIndexValue,
        onDestinationSelected: (int index) => _navRailCtrl.goTo(index),
        labelType: NavigationRailLabelType.selected,
        groupAlignment: 0,
        selectedLabelTextStyle: TextStyle(color: AppColors.textOrange),
        selectedIconTheme: IconThemeData(color: AppColors.secondaryOrange),
        unselectedIconTheme: IconThemeData(color: AppColors.textLightOrange),
        destinations: [
          NavigationRailDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(FontAwesome.home),
            label: Text('Início'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.new_releases),
            selectedIcon: Icon(FontAwesome.newspaper),
            label: Text('Notícias'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(FontAwesome5.portrait),
            label: Text('Perfil'),
          ),
        ],
      ),
    );
  }
}
