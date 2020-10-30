import 'package:dio/dio.dart';

abstract class IHttpServices {
  void addToken(String token);

  Future get(String urlPath);

  Future post(String urlPath, Map<String, dynamic> bodyData, {Options options});
}
