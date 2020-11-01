import 'package:challenge_bt_app/app/global/custom/api_consts.dart';
import 'package:challenge_bt_app/app/global/custom_dio/custom_dio.dart';
import 'package:challenge_bt_app/app/global/models/login_response_model.dart';
import 'package:challenge_bt_app/app/global/services/local_db_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AuthRepository {
  final localDb = Get.find<LocalDatabase>();

  Dio _httpService;

  AuthRepository() {
    _httpService = Dio();
    _httpService.options.baseUrl = BASEURL;
    _httpService.interceptors.add(CustomInterceptors());
  }

  String token;
  String refresh;

  Future login(Map<String, dynamic> loginData) async {
    refresh = await localDb.getItem(REFRESHTOKEN);

    try {
      var response = await _httpService.post('/auth/login', data: loginData);

      if (response.statusCode == 200) {
        LoginResponseModel loginResponse = LoginResponseModel.fromJson(response.data);

        await localDb.setItemString(ACCESSTOKEN, loginResponse.accessToken);
        await localDb.setItemString(REFRESHTOKEN, loginResponse.refreshToken);
        await localDb.setItemInt(USERID, loginResponse.userId);

        token = await localDb.getItem(ACCESSTOKEN);
        refresh = await localDb.getItem(REFRESHTOKEN);

        print('User: ${loginResponse.username} de Id:  ${loginResponse.userId}');

        return loginResponse;
      }
    } on DioError catch (e) {
      return e;
    }
  }

  Future signup(FormData signupData) async {
    try {
      var response = await _httpService.post('/users', data: signupData);

      if (response.statusCode == 201) {
        LoginResponseModel loginResponse = LoginResponseModel.fromJson(response.data);

        print('User: ${loginResponse.username} de Id:  ${loginResponse.userId}');

        return loginResponse;
      }
    } on DioError catch (e) {
      return e;
    }
  }
}
