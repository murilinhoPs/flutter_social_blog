import 'package:challenge_bt_app/app/global/repositories/http_service_repository.dart';
import 'package:challenge_bt_app/app/modules/last_news/news_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class NewsController extends GetxController {
  var noticias = List<NewsModel>().obs;
  List<NewsModel> get noticiasValue => noticias;
  void setNoticias(List<NewsModel> value) => noticias.value = value;

  @override
  void onInit() async {
    getPosts();
    super.onInit();
  }

  getPosts() async {
    try {
      var _response = await Get.find<HttpServiceRepository>().get('/news');

      List<dynamic> newResponse = _response;

      List<NewsModel> allPostsList = newResponse.map((v) => NewsModel.fromJson(v)).toList();

      setNoticias(allPostsList);
    } on DioError catch (e) {
      return e;
    }
  }
}
