import 'package:get/get.dart';
import 'package:flutter/material.dart';

enum FetchState { isLoading, finishedLoading, errorLoading }

class HttpServiceController extends GetxController {
  final state = FetchState.finishedLoading.obs;

  void changeState(FetchState fetchState) {
    state.value = fetchState;

    if (fetchState == FetchState.errorLoading) showWarning();
  }

  void showWarning(
      {String mensagem = 'Houve um erro na requisição, tente novamente: ',
      String errorMessage = '',
      String title = 'Erro!'}) {
    GetPlatform.isAndroid
        ? Get.snackbar(
            title,
            mensagem + errorMessage,
            duration: Duration(seconds: 5),
            snackPosition: SnackPosition.BOTTOM,
            backgroundGradient: null,
            backgroundColor: Colors.black.withOpacity(0.7),
            colorText: Colors.white,
            borderRadius: 0,
            snackStyle: SnackStyle.GROUNDED,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
          )
        : Get.snackbar(
            'Erro',
            mensagem + errorMessage,
            duration: Duration(seconds: 5),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.white.withOpacity(0.7),
          );
  }
}
