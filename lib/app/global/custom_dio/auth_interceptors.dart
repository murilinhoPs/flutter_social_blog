import 'package:challenge_bt_app/app/global/custom/api_consts.dart';
import 'package:challenge_bt_app/app/global/custom_dio/custom_dio.dart';
import 'package:challenge_bt_app/app/global/services/local_db_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AuthInterceptors implements InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    final localDb = Get.find<LocalDatabase>();
    final globalDio = Get.find<GlobalDio>();

    String token = await localDb.getItem(accessToken);
    String refresh = await localDb.getItem(refreshToken);

    if (token != null) {
      globalDio.dio.lock();

      print(token);

      Map<String, dynamic> customHeaders = {'Authorization': token, refreshTokenHeader: refresh};

      options.headers.addAll(customHeaders);

      globalDio.dio.unlock();

      return options;
    }

    print("Request: ${options.method} -> Path: ${options.path}");
  }

  @override
  Future onResponse(Response response) async {
    print("Response: ${response.statusCode} -> Path: ${response.data}");
  }

  @override
  Future onError(DioError err) async {
    print("Error: ${err.response.statusCode} ->  Data: ${err.response.data}->Path: ${err.message}");

    return err;
  }
}
