import 'package:challenge_bt_app/app/global/controllers/http_service_state_ctrl.dart';
import 'package:challenge_bt_app/app/global/custom/api_consts.dart';
import 'package:challenge_bt_app/app/global/services/local_db_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'auth_interceptors.dart';

class GlobalDio {
  Dio dio;

  GlobalDio() {
    configDio();
  }

  void configDio() {
    dio = Dio();
    dio.options.baseUrl = BASEURL;

    // dio.options.connectTimeout = 10000; //5s
    // dio.options.receiveTimeout = 10000;

    configAuthHeader();

    dio.interceptors.add(AuthInterceptors());
    dio.interceptors.add(CustomInterceptors());
  }

  void configAuthHeader() async {
    String token = await Get.find<LocalDatabase>().getItem(ACCESSTOKEN);
    String refresh = await Get.find<LocalDatabase>().getItem(REFRESHTOKEN);

    if (token != null) dio.options.headers = {'authorization': token};

    if (refresh != null) dio.options.headers = {REFRESHTOKENHEADER: refresh};
  }
}

class CustomInterceptors implements InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    print("Request: ${options.method} -> Path: ${options.path}");

    return options;
  }

  @override
  Future onResponse(Response response) async {
    print("Response: ${response.statusCode} -> Path: ${response.data}");

    return response;
  }

  @override
  Future onError(DioError err) async {
    print(
        "Error: ${err.response.statusCode} ->  Data: ${err.response.data["message"]} ->Path: ${err.message}");

    if (err.response.statusCode >= 400)
      Get.find<HttpServiceController>().showWarning(errorMessage: err.response.data["message"]);

    return err;
  }
}
