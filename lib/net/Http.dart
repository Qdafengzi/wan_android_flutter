import 'package:dio/dio.dart';

class Http {
  static Http instance;
  static String token;
  static final baseUrl = "https://www.wanandroid.com/";
  static Dio _dio;

  static Http getInstance() {
    print("getInstance");
    if (instance == null) {
      instance = new Http();
    }
  }

  Http() {
    // 初始化 Options

    BaseOptions baseOptions = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 5000,
    );

    _dio = new Dio(baseOptions);

    //发送请求拦截处理，例如：添加token使用
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      print(options.baseUrl);
      print(options.queryParameters);
      print(options.connectTimeout);
      print(options.contentType);
      print(options.method);
      print(options.headers);
      print(options.receiveTimeout);
    }));

    _dio.interceptors.add(InterceptorsWrapper(onResponse: (Response response) {
      print("response:-----------------" + response.statusCode.toString());
      print("response:-----------------" + response.data);
      print("response:-----------------" + response.headers.toString());
      print("response:-----------------" + response.statusMessage);
      print("response:-----------------" + response.realUri.toString());
    }));
  }

  // get 请求封装
  get(url, {options, cancelToken, data = null}) async {
    print('get-------------------url：$url ,body: $data');
    Response response;
    try {
      response =
          await _dio.get(url, queryParameters: data, cancelToken: cancelToken);
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('get请求取消! ' + e.message);
      } else {
        print('get请求发生错误：$e');
      }
    }
    return response.data;
  }

  // post请求封装
  post(url, {options, cancelToken, data = null}) async {
    print('post请求::: url：$url ,body: $data');
    Response response;

    try {
      response = await _dio.post(url,
          data: data != null ? data : {}, cancelToken: cancelToken);
      print(response);
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('get请求取消! ' + e.message);
      } else {
        print('get请求发生错误：$e');
      }
    }
    return response.data;
  }
}
