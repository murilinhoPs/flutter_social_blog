import 'package:challenge_bt_app/app/global/custom/api_consts.dart';
import 'package:challenge_bt_app/app/global/custom_dio/auth_interceptors.dart';
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
    _httpService.options.baseUrl = baseUrl;
    _httpService.interceptors.add(CustomInterceptors());
  }

  String token = '';
  String refresh = '';

  Future<LoginResponseModel> login(Map<String, dynamic> loginData) async {
    token = await localDb.getItem(accessToken);
    refresh = await localDb.getItem(refreshToken);

    try {
      var response = await _httpService.post('/auth/login', data: loginData);

      LoginResponseModel loginResponse = LoginResponseModel.fromJson(response.data);

      localDb.setItemString(accessToken, loginResponse.accessToken);
      localDb.setItemString(refreshToken, loginResponse.refreshToken);

      print(loginResponse.username);

      return loginResponse;
    } catch (e) {
      print(e);
    }
  }
}
