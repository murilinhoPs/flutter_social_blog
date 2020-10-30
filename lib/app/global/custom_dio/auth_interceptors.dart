import 'package:challenge_bt_app/app/global/controllers/auth_ctrl.dart';
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

    if (token != null) {
      globalDio.dio.lock();

      print(token);

      Map<String, dynamic> customHeaders = {
        'Authorization': token + '12',
        REFRESHTOKENHEADER: refresh
      };

      options.headers.addAll(customHeaders);

      globalDio.dio.unlock();

      return options;
    }

    print("Request: ${options.method} -> Path: ${options.path}");
    return options;
  }

  @override
  Future onResponse(Response response) async {
    print("Response: ${response.statusCode} -> Path: ${response.data}");

    if (response.data['refreshAccess']) {
      final globalDio = Get.find<GlobalDio>();
      RequestOptions options = response.request;

      globalDio.dio.lock();
      globalDio.dio.interceptors.responseLock.lock();
      globalDio.dio.interceptors.errorLock.lock();

      options.headers['Authorization'] = response.data['accessToken'];
    }
  }

  @override
  Future onError(DioError err) async {
    print('''Error: ${err.response.statusCode} ->  
    Data: ${err.response.data}-> 
    Path: ${err.message}''');

    print(token);

    if (err.response.statusCode == 401 || err.response.statusCode == 403) {
      final globalDio = Get.find<GlobalDio>();

      final authCtrl = Get.find<AuthController>();
      RequestOptions options = err.response.request;

      // if (authCtrl.token != options.headers["Authorization"]) {
      //   options.headers["Authorization"] = authCtrl.token;

      //   return globalDio.dio.request(options.path, options: options);
      // }

      globalDio.dio.lock();
      globalDio.dio.interceptors.responseLock.lock();
      globalDio.dio.interceptors.errorLock.lock();

      print('Error new token: ${err.response}');

      // return globalDio.dio.unlock();
      // globalDio.dio.interceptors.responseLock.unlock();
      // globalDio.dio.interceptors.errorLock.unlock();

      print('''Error: ${err.response.statusCode} ->  
    Data: ${err.response.data}-> 
    Path: ${err.message}''');

      return err;
    }

    return err;
  }
}