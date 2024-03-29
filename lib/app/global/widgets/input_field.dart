import 'package:challenge_bt_app/app/global/custom/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputField extends StatelessWidget {
  final String labelText;
  final String initialValue;
  final bool obscureTxt;
  final bool hasError;
  final bool expands;
  final Function clearError;
  final Function(String) submit;
  final Function(String) onChanged;
  final String Function() setErrorTxt;

  InputField(
      {this.labelText,
      this.obscureTxt,
      this.onChanged,
      this.setErrorTxt,
      this.hasError,
      this.clearError,
      this.submit,
      this.expands = false,
      this.initialValue = ''});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Get.theme.accentColor,
      cursorHeight: 25,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 5),
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
        errorText: !hasError ? null : setErrorTxt(),
      ),
      onChanged: onChanged,
      obscureText: obscureTxt,
      onTap: clearError,
      onFieldSubmitted: submit,
      maxLines: expands ? null : 1,
      minLines: expands ? null : 1,
      expands: expands,
      initialValue: initialValue,
    );
  }
}
