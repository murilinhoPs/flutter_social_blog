import 'package:challenge_bt_app/app/global/consts/api_consts.dart';
import 'package:challenge_bt_app/app/global/services/local_db_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class GlobalDio {
  final dio = Dio();
  final localDb = Get.find<LocalDatabase>();

  GlobalDio() {
    configDio();
  }

  void configDio() async {
    dio.options.baseUrl = baseUrl;

    dio.options.connectTimeout = 10000; //5s
    dio.options.receiveTimeout = 10000;

    dio.interceptors.add(CustomInterceptors());
  }

  void configAuthHeader() async {
    String token = await localDb.getItem(accessToken);
    String refresh = await localDb.getItem(refreshToken);

    if (token != null) dio.options.headers = {'authorization': token};

    if (refresh != null) dio.options.headers = {refreshTokenHeader: refresh};
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
  }

  @override
  Future onError(DioError err) async {
    print("Error: ${err.response.statusCode} -> Path: ${err.message}");
    return err;
  }
}
