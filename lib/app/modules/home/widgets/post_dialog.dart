import 'package:challenge_bt_app/app/global/custom/app_colors.dart';
import 'package:challenge_bt_app/app/global/widgets/input_field.dart';
import 'package:challenge_bt_app/app/global/widgets/loading_indicator.dart';
import 'package:challenge_bt_app/app/modules/home/controllers/create_post_ctrl.dart';
import 'package:challenge_bt_app/app/modules/home/home_page.dart';
import 'package:challenge_bt_app/app/modules/log_in/controllers/loading_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';

class PostDialog extends StatelessWidget {
  final _postController = Get.put(CreatePostController());
  final _loadingController = Get.find<LoadingController>();

  _onSubmit(context) {
    _loadingController.setIsLoading(true);

    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    _postController.createPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            FontAwesome.cancel,
            size: 26.0,
            color: AppColors.textOrange,
          ),
          onPressed: () => navigator.pop(),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 80,
                width: Get.context.mediaQuerySize.width * 0.85,
                child: Obx(
                  () => InputField(
                    clearError: _postController.clearErrors,
                    hasError: _postController.canCheckErrorValue,
                    labelText: "Email ou usuário",
                    obscureTxt: false,
                    onChanged: _postController.setPostContent,
                    setErrorTxt: _postController.validatePost,
                  ),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
                onPressed: () => _onSubmit(context),
                child: _loadingController.isLoading.value
                    ? Container(
                        height: 30,
                        width: 30,
                        child: LoadingIndicator(
                          color: AlwaysStoppedAnimation<Color>(AppColors.textWhite),
                        ),
                      )
                    : Text(
                        'Postar',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
