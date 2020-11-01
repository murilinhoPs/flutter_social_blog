import 'package:get/get.dart';

class LoadingController extends GetxController {
  var isLoading = false.obs;

  setIsLoading(bool value) => isLoading.value = value;
}
