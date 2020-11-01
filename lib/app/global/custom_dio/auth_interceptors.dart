import 'package:challenge_bt_app/app/global/custom/api_consts.dart';
import 'package:challenge_bt_app/app/global/custom_dio/custom_dio.dart';
import 'package:challenge_bt_app/app/global/services/local_db_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AuthInterceptors implements InterceptorsWrapper {
  String token;
  String refresh;

  @override
  Future onRequest(RequestOptions options) async {
    final globalDio = Get.find<GlobalDio>();
    final localDb = Get.find<LocalDatabase>();

    token = await localDb.getItem(ACCESSTOKEN);
    refresh = await localDb.getItem(REFRESHTOKEN);

    Map<String, dynamic> customHeaders = {'Authorization': token, REFRESHTOKENHEADER: refresh};

    if (token != null) {
      globalDio.dio.lock();

      print(token);
      print(refresh);

      options.headers.addAll(customHeaders);

      globalDio.dio.unlock();

      print("Request: ${options.method} -> Path: ${options.path}");

      return options;
    }

    print("Request: ${options.method} -> Path: ${options.path}");

    return options;
  }

  @override
  Future onResponse(Response response) async {
    print("ResponseAuth: ${response.statusCode} -> Path: ${response.data}");

    if (!(response.data is List)) if (response.data['refreshAccess'] != null) {
      final globalDio = Get.find<GlobalDio>();
      final localDb = Get.find<LocalDatabase>();

      print(response.data['refreshAccess']);

      RequestOptions options = response.request;

      globalDio.dio.lock();
      globalDio.dio.interceptors.responseLock.lock();
      globalDio.dio.interceptors.errorLock.lock();

      localDb.setItemString(ACCESSTOKEN, response.data['accessToken']);

      options.headers['Authorization'] = await localDb.getItem(ACCESSTOKEN);

      print(options.headers);

      globalDio.dio.unlock();
      globalDio.dio.interceptors.responseLock.unlock();
      globalDio.dio.interceptors.errorLock.unlock();

      return globalDio.dio.request(options.path, options: options);
    }

    print(response);

    return response;
  }

  @override
  Future onError(DioError err) async {
    print('''Error: ${err.response?.statusCode} ->
    Data: ${err.response?.data}->
    Path: ${err.message}''');

    if (!(err.response.data is List)) if (err.response.data['message'] ==
        'Refresh token errado ou inválido. Faça login novamente') Get.toNamed('/login');

    return err;
  }
}
