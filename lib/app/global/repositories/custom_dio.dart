import 'package:challenge_bt_app/app/global/services/local_db_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class GlobalDio {
  final dio = Dio();
  final localDb = Get.find<LocalDatabase>();

  final baseUrl = "https://jsonplaceholder.typicode.com";

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
    String token = "";

    if (await localDb.getItem("token") != null) {
      token = await localDb.getItem("token");

      dio.options.headers = {'authentication': 'Bearer $token'};
    }
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
