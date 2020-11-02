import 'package:challenge_bt_app/app/global/custom/api_consts.dart';
import 'package:challenge_bt_app/app/global/repositories/http_service_repository.dart';
import 'package:challenge_bt_app/app/global/controllers/loading_controller.dart';
import 'package:challenge_bt_app/app/global/services/local_db_service.dart';
import 'package:challenge_bt_app/app/modules/home/controllers/response_home_ctrl.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

enum EnumMethod { POST, PUT }

class PostController extends GetxController {
  final _httpServiceRepository = Get.find<HttpServiceRepository>();

  var postContent = ''.obs;
  String get postContentValue => postContent.value;
  setPostContent(String value) => postContent.value = value;

  bool hasError = true;
  setHasError(bool value) => hasError = value;

  var canCheckError = false.obs;
  bool get canCheckErrorValue => canCheckError.value;
  void clearErrors() => canCheckError.value = false;

  var method = Rx<EnumMethod>();
  EnumMethod get methodValue => method.value;
  void setMethod(EnumMethod value) => method.value = value;

  @override
  void onInit() {
    setMethod(EnumMethod.POST);

    print(postContentValue);

    super.onInit();
  }

  String validatePost() {
    print(Get.arguments);

    if (canCheckErrorValue) {
      if (postContentValue == '' || postContentValue.isEmpty) {
        setHasError(true);
        return 'O campo é obrigatório';
      }

      if (postContentValue.length >= 280) {
        setHasError(true);
        return 'No máximo 280 caracteres';
      }
    }

    setHasError(false);

    return null;
  }

  createPost() async {
    canCheckError.value = true;
    validatePost();

    print(postContentValue.length);

    if (hasError) return Get.find<LoadingController>().setIsLoading(false);

    if (!hasError) {
      int userId = await Get.find<LocalDatabase>().getItem(USERID);

      await _httpServiceRepository.post('/posts/$userId', {'post': postContent});

      Get.find<LoadingController>().setIsLoading(false);

      terminatedOperation();
    }
  }

  updatePost(int postId) async {
    canCheckError.value = true;
    validatePost();

    print(postContentValue.length);

    if (hasError) return Get.find<LoadingController>().setIsLoading(false);

    if (!hasError) {
      int userId = await Get.find<LocalDatabase>().getItem(USERID);

      await _httpServiceRepository.put('/posts/$userId/$postId', {'post': postContent});

      Get.find<LoadingController>().setIsLoading(false);

      terminatedOperation();
    }
  }

  deletePost(int postId) async {
    canCheckError.value = true;
    validatePost();

    if (hasError) return Get.find<LoadingController>().setIsLoading(false);

    if (!hasError) {
      int userId = await Get.find<LocalDatabase>().getItem(USERID);

      await _httpServiceRepository.delete('/posts/$userId/$postId');

      Get.find<LoadingController>().setIsLoading(false);

      await terminatedOperation();
    }
  }

  terminatedOperation() async {
    setPostContent('');
    setHasError(false);
    clearErrors();

    await Get.find<HomeController>().getPosts();

    navigator.popUntil(ModalRoute.withName('/home'));
  }
}
