import 'package:flutter/material.dart';

import 'app_colors.dart';

class CustomTheme {
  static final customTheme = ThemeData(
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(AppColors.primaryOrange),
        overlayColor: MaterialStateProperty.all<Color>(AppColors.secondaryOrange),
      ),
    ),
    primaryColor: AppColors.secondaryOrange,
    accentColor: AppColors.primaryOrange,
    scaffoldBackgroundColor: AppColors.backgroundColor,
  );
}
