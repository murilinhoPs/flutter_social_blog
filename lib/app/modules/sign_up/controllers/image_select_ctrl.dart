import 'dart:io';

import 'package:get/get.dart';

class ImageSelectController extends GetxController {
  var image = File(null).obs;
  File get imageValue => image.value;

  void setImage(File file) => image.value = file;

  var hasImage = false.obs;
  bool get hasImageValue => hasImage.value;

  void setHasImage(bool value) => hasImage.value = value;
}
