import 'dart:io';

import 'package:challenge_bt_app/app/global/controllers/http_service_state_ctrl.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelectController extends GetxController {
  final _imagePicker = ImagePicker();

  var image = File('').obs;
  File get imageValue => image.value;

  void setImage(File file) => image.value = file;

  var hasImage = false.obs;
  bool get hasImageValue => hasImage.value;

  void setHasImage(bool value) => hasImage.value = value;

  var hasError = false.obs;
  bool get hasErrorValue => hasError.value;

  void setHasError(bool value) => hasError.value = value;

  Future getImage() async {
    setHasError(false);

    var imageResult = await _imagePicker.getImage(
      source: ImageSource.gallery,
    );

    if (imageResult != null) {
      setHasImage(true);

      setImage(File(imageResult.path));

      var imageBytes = imageValue.readAsBytesSync();

      double imageMb = (imageBytes.lengthInBytes / 1000000).toPrecision(2);

      print(imageMb);

      if (imageMb >= 5.0) {
        setImage(File(''));

        setHasError(true);
      }
    } else {
      setHasImage(false);

      return Get.find<HttpServiceController>().showWarning(mensagem: 'Nenhuma imagem selecionada');
    }
  }
}
