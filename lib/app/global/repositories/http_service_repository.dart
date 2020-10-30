import 'package:challenge_bt_app/app/global/controllers/http_service_state_ctrl.dart';
import 'package:challenge_bt_app/app/global/interfaces/http_service_interface.dart';
import 'package:challenge_bt_app/app/global/custom_dio/custom_dio.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class HttpServiceRepository implements IHttpServices {
  final _httpController = Get.find<HttpServiceController>();
  final _globalDio = Get.find<GlobalDio>();

  @override
  void addToken(String token) {}

  @override
  Future get(String urlPath) async {
    _httpController.changeState(FetchState.isLoading);

    try {
      var response = await _globalDio.dio.get(urlPath).timeout(
        Duration(seconds: 30),
        onTimeout: () {
          _httpController.changeState(FetchState.errorLoading);
          return;
        },
      );

      return response.data;
    } catch (err) {
      _httpController.changeState(FetchState.errorLoading);

      throw "There's something wrong with connection: " + err.toString();
    }
  }

  @override
  Future post(String urlPath, Map<String, dynamic> bodyData, {Options options}) async {
    _httpController.changeState(FetchState.isLoading);

    try {
      var response = await _globalDio.dio.post(urlPath, data: bodyData).timeout(
        Duration(seconds: 30),
        onTimeout: () {
          _httpController.changeState(FetchState.errorLoading);
          return;
        },
      );

      return response.data;
    } catch (err) {
      _httpController.changeState(FetchState.errorLoading);

      throw "There's something wrong with connection: " + err.toString();
    }
  }
}
