import 'package:challenge_bt_app/app/global/custom/api_consts.dart';
import 'package:challenge_bt_app/app/global/repositories/http_service_repository.dart';
import 'package:challenge_bt_app/app/global/controllers/loading_controller.dart';
import 'package:challenge_bt_app/app/global/services/local_db_service.dart';
import 'package:get/get.dart';

class CreatePostController {
  final _httpServiceRepository = Get.find<HttpServiceRepository>();

  var postContent = ''.obs;
  String get postContentValue => postContent.value;

  setPostContent(String value) => postContent.value = value;

  bool hasError = true;
  setHasError(bool value) => hasError = value;

  var canCheckError = false.obs;
  bool get canCheckErrorValue => canCheckError.value;
  void clearErrors() => canCheckError.value = false;

  String validatePost() {
    print(Get.arguments[0]);

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

      var response = await _httpServiceRepository.post('/posts/$userId', {'post': postContent});

      Get.find<LoadingController>().setIsLoading(false);

      print(response);

      navigator.pop();
    }
  }

  cancelOperation() {
    setPostContent('');
    setHasError(false);
    clearErrors();
    navigator.pop();
  }
}
