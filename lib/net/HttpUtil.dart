import 'dart:async';

import "package:dio/dio.dart";

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();
  Dio _client;

  factory HttpUtil() => _instance;

  HttpUtil._internal() {
    if (null == _client) {
      BaseOptions baseOptions = new BaseOptions(
        baseUrl: "http://www.wanandroid.com/",
        receiveTimeout: 1000 * 10,
        connectTimeout: 5000,
      );

      _client = new Dio(baseOptions);
    }
  }

  Future<Map<String, dynamic>> get(String path,
      [Map<String, dynamic> params]) async {
    Response<Map<String, dynamic>> response;
    if (null != params) {
      response = await _client.get(path, queryParameters: params);
    } else {
      response = await _client.get(path);
    }
    return response.data;
  }
//...省略post等方法...
}
