import 'package:dio/dio.dart';

abstract class IHttpServices {
  void addToken(String token);

  Future get(String urlPath);

  Future post(String urlPath, dynamic bodyData, Options options);
}
