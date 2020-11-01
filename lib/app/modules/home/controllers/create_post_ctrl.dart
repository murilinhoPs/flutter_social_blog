import 'package:challenge_bt_app/app/global/custom/api_consts.dart';
import 'package:challenge_bt_app/app/global/repositories/http_service_repository.dart';
import 'package:challenge_bt_app/app/global/services/local_db_service.dart';
import 'package:challenge_bt_app/app/modules/log_in/controllers/loading_controller.dart';
import 'package:get/get.dart';

class CreatePostController {
  final _httpServiceRepository = Get.find<HttpServiceRepository>();

  var postContent = ''.obs;
  String get postContentValue => postContent.value;

  setPostContent(String value) => postContent.value = value;

  var hasError = true.obs;
  setHasError(bool value) => hasError.value = value;

  var canCheckError = false.obs;
  bool get canCheckErrorValue => canCheckError.value;
  void clearErrors() => canCheckError.value = false;

  String validatePost() {
    if ((postContentValue == '' || postContentValue.isEmpty) && canCheckErrorValue) {
      setHasError(true);
      return 'O campo é obrigatório';
    }

    setHasError(false);

    return null;
  }

  createPost() async {
    canCheckError.value = true;
    validatePost();

    if (hasError.value) Get.find<LoadingController>().setIsLoading(false);

    print(hasError);

    if (!hasError.value) {
      int userId = await Get.find<LocalDatabase>().getItem(USERID);

      var response = await _httpServiceRepository.post('/posts/$userId', {'post': postContent});

      Get.find<LoadingController>().setIsLoading(false);

      print(response);

      navigator.pop();
    }
  }
}
