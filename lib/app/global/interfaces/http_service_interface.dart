import 'package:dio/dio.dart';

abstract class IHttpServices {
  void addToken(String token);

  Future get(String urlPath);

  Future post(String urlPath, Map<String, dynamic> bodyData, {Options options});

  Future put(String urlPath, Map<String, dynamic> bodyData, {Options options});

  Future delete(String urlPath);
}
