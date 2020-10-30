import 'package:challenge_bt_app/app/global/custom/api_consts.dart';
import 'package:challenge_bt_app/app/global/custom_dio/custom_dio.dart';
import 'package:challenge_bt_app/app/global/models/login_response_model.dart';
import 'package:challenge_bt_app/app/global/services/local_db_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AuthController {
  final localDb = Get.find<LocalDatabase>();

  Dio _httpService;

  AuthController() {
    _httpService = Dio();
    _httpService.options.baseUrl = BASEURL;
    _httpService.interceptors.add(CustomInterceptors());
  }

  String token;
  String refresh;

  Future login(Map<String, dynamic> loginData) async {
    // await localDb.deleteItem(REFRESHTOKEN);

    refresh = await localDb.getItem(REFRESHTOKEN);

    try {
      var response = await _httpService.post('/auth/login', data: loginData);

      if (response.statusCode == 200) {
        LoginResponseModel loginResponse = LoginResponseModel.fromJson(response.data);

        localDb.setItemString(ACCESSTOKEN, loginResponse.accessToken);
        if (refresh == null) localDb.setItemString(REFRESHTOKEN, loginResponse.refreshToken);
        localDb.setItemInt(USERID, loginResponse.userId);

        token = await localDb.getItem(ACCESSTOKEN);
        refresh = await localDb.getItem(REFRESHTOKEN);

        print(loginResponse.username);

        Get.toNamed('/home');

        return loginResponse;
      }
    } on DioError catch (e) {
      print(e);
    }
  }

  Future generateToken(Map<String, dynamic> loginData) async {
    refresh = await localDb.getItem(REFRESHTOKEN);

    try {
      var response = await _httpService.post('/auth/login', data: loginData);

      if (response.statusCode == 200) {
        LoginResponseModel loginResponse = LoginResponseModel.fromJson(response.data);

        localDb.setItemString(ACCESSTOKEN, loginResponse.accessToken);
        if (refresh == null) localDb.setItemString(REFRESHTOKEN, loginResponse.refreshToken);
        localDb.setItemInt(USERID, loginResponse.userId);

        token = await localDb.getItem(ACCESSTOKEN);
        refresh = await localDb.getItem(REFRESHTOKEN);

        print(loginResponse.username);

        Get.toNamed('/home');

        return loginResponse;
      }
    } on DioError catch (e) {
      print(e);
    }
  }
}
