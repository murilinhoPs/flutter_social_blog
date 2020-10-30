import 'package:challenge_bt_app/app/global/custom/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputField extends StatelessWidget {
  final String labelText;
  final bool obscureTxt;
  final Function(String) onChanged;
  final String Function() setErrorTxt;

  InputField({this.labelText, this.obscureTxt, this.onChanged, this.setErrorTxt});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Get.theme.accentColor,
      cursorHeight: 25,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 15),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: labelText,
        labelStyle: TextStyle(color: AppColors.textWhite, fontSize: 21),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Get.theme.primaryColor, width: 3.0),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.lighterBackground,
          ),
        ),
        errorText: setErrorTxt == null ? null : setErrorTxt(),
      ),
      onChanged: onChanged,
      obscureText: obscureTxt,
    );
  }
}
