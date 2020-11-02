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

  var canCheckError = false.obs;
  bool get canCheckErrorValue => canCheckError.value;
  void clearErrors() => canCheckError.value = false;

  var method = Rx<EnumMethod>();
  EnumMethod get methodValue => method.value;
  void setMethod(EnumMethod value) => method.value = value;

  bool hasError = true;
  setHasError(bool value) => hasError = value;

  int postId;
  setPostId(int id) => postId = id;

  @override
  void onInit() {
    setMethod(EnumMethod.POST);

    super.onInit();
  }

  String validatePost() {
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

    if (hasError) return Get.find<LoadingController>().setIsLoading(false);

    if (!hasError) {
      int userId = await Get.find<LocalDatabase>().getItem(USERID);

      await _httpServiceRepository.post('/posts/$userId', {'post': postContent});

      Get.find<LoadingController>().setIsLoading(false);

      await Get.find<HomeController>().getPosts();

      terminatedOperation();
    }
  }

  updatePost() async {
    canCheckError.value = true;
    validatePost();

    if (hasError) return Get.find<LoadingController>().setIsLoading(false);

    if (!hasError) {
      int userId = await Get.find<LocalDatabase>().getItem(USERID);

      await _httpServiceRepository.put('/posts/$userId/$postId', {'post': postContent});

      Get.find<LoadingController>().setIsLoading(false);

      await Get.find<HomeController>().getPosts();

      terminatedOperation();
    }
  }

  deletePost() async {
    Get.find<LoadingController>().setIsLoading(true);

    canCheckError.value = true;
    validatePost();

    if (hasError) return Get.find<LoadingController>().setIsLoading(false);

    if (!hasError) {
      int userId = await Get.find<LocalDatabase>().getItem(USERID);

      await _httpServiceRepository.delete('/posts/$userId/$postId');

      Get.find<LoadingController>().setIsLoading(false);

      await Get.find<HomeController>().getPosts();

      terminatedOperation();
    }
  }

  terminatedOperation() {
    setPostContent('');
    setHasError(false);
    clearErrors();

    navigator.popUntil(ModalRoute.withName('/home'));
  }
}
