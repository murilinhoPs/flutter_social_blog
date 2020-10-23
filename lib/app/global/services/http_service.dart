import 'package:challenge_bt_app/app/global/controllers/http_service_state_ctrl.dart';
import 'package:challenge_bt_app/app/global/interfaces/http_service_interface.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class HttpService implements IHttpServices {
  final _httpController = Get.find<HttpServiceController>();

  @override
  void addToken(String token) {}

  @override
  Future get(String urlPath) async {
    _httpController.changeState(FetchState.isLoading);

    try {
      var response = await Get.find<Dio>().get(urlPath).timeout(
        Duration(seconds: 30),
        onTimeout: () {
          _httpController.changeState(FetchState.errorLoading);
          return;
        },
      );

      if (response.statusCode == 200)
        return response.data;
      else {
        _httpController.changeState(FetchState.errorLoading);

        throw "Returned error code from api: ${response.statusCode}";
      }
    } catch (err) {
      _httpController.changeState(FetchState.errorLoading);

      throw "There's something wrong with connection: " + err.toString();
    }
  }

  @override
  Future post(String urlPath, bodyData, Options options) {
    // TODO: implement post
    throw UnimplementedError();
  }
}
