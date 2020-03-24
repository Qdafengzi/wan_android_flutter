import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:wanandroid/bean/BannerData.dart';
import 'package:wanandroid/bean/home_article_data_entity.dart';
import 'package:wanandroid/my/login_back_bean_entity.dart';
import 'package:wanandroid/my/register_back_bean_entity.dart';
import 'package:wanandroid/navigator/nav_data_entity.dart';
import 'package:wanandroid/net/Api.dart';
import 'package:wanandroid/system/system_data_data_entity.dart';
import 'package:wanandroid/system/system_data_entity.dart';
import 'package:wanandroid/utils/ToastUtils.dart';

import 'OnHttpListener.dart';

//普通格式的header
Map<String, dynamic> headers = {
  "Accept": "application/json",
//  "Content-Type":"application/x-www-form-urlencoded",
};
//json格式的header
Map<String, dynamic> headersJson = {
  "Accept": "application/json",
  "Content-Type": "application/json; charset=UTF-8",
};

class HttpUtils {
  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 3000;

  //json格式的header
  Map<String, dynamic> headersJson = {
    "Accept": "application/json",
    "Content-Type": "application/json; charset=UTF-8",
  };

  Dio dio;
  BaseOptions options;

  ///公开访问点
  factory HttpUtils() => _getInstance();

  static HttpUtils get instance => _getInstance();

  ///静态私有成员没有初始化
  static HttpUtils _instance;

  HttpUtils._internal() {
    // 初始化

    print('dio赋值');
    // 或者通过传递一个 `options`来创建dio实例
    options = BaseOptions(
      // 请求基地址，一般为域名，可以包含路径
      baseUrl: Api.BASE_URL,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: CONNECT_TIMEOUT,
      //[如果返回数据是json(content-type)，dio默认会自动将数据转为json，无需再手动转](https://github.com/flutterchina/dio/issues/30)
      responseType: ResponseType.plain,

      ///  响应流上前后两次接受到数据的间隔，单位为毫秒。如果两次间隔超过[receiveTimeout]，
      ///  [Dio] 将会抛出一个[DioErrorType.RECEIVE_TIMEOUT]的异常.
      ///  注意: 这并不是接收数据的总时限.
      receiveTimeout: RECEIVE_TIMEOUT,
      headers: headersJson,
    );
    dio = new Dio(options);
    dio.interceptors.add(CookieManager(CookieJar()));
  }

  static HttpUtils _getInstance() {
    if (_instance == null) {
      _instance = HttpUtils._internal();
    }
    return _instance;
  }

  ///首页banner数据
  void getBannerData(Function callBack) async {
    await dio.get(Api.HOME_BANNER).then((response) {
      print("首页banner数据：" + response.data);
      Map<String, dynamic> json = jsonDecode(response.data);
      callBack(BannerData.fromJson(json));
    }).catchError((e) {
      showToast(e.toString());
    });
  }

  ///获取文章列表
  void getArticleListData(int pageIndex, Function callBack) async {
    await dio.get("${Api.HOME_ARTICLE_LIST}$pageIndex/json").then((response) {
      print("首页文章列表888888：" + response.data);
      Map<String, dynamic> jsonMap = jsonDecode(response.data);
      callBack(HomeArticleDataEntity.fromJson(jsonMap));
    }).catchError((e) {
      showToast(e.toString());
    });
  }

  ///获取体系数据
  void getSystemData(Function callBack) async {
    await dio.get(Api.SYSTEM_DATA).then((response) {
      print("体系数据：" + response.data);
      Map<String, dynamic> json = jsonDecode(response.data);
      callBack(SystemDataEntity.fromJson(json));
    }).catchError((e) {
      showToast(e.toString());
    });
  }

  ///获取体系数据的数据（嵌套有些深，醉了）
  void getSystemDataData(int page, int cid, Function callBack) async {
    await dio
        .get(Api.SYSTEM_DATA_CID + "${page}" + "/json?cid=${cid}")
        .then((response) {
      print("体系数据的数据：" + response.data);
      Map<String, dynamic> json = jsonDecode(response.data);
      callBack(SystemDataDataEntity.fromJson(json));
    }).catchError((e) {
      showToast(e.toString());
    });
  }

  ///获取导航的数据
  void getNavData(Function callBack) async {
    await dio.get(Api.NAV_DATA).then((response) {
      print("导航数据：" + response.data);
      Map<String, dynamic> json = jsonDecode(response.data);
      callBack(NavDataEntity.fromJson(json));
    }).catchError((e) {
      showToast(e.toString());
    });
  }

  ///登陆
  void login(String username, String pwd, Function callBack) async {
    FormData formData = new FormData.from({
      "username": "$username",
      "password": "$pwd",
    });
    await dio.post(Api.LOGIN, data: formData).then((response) {
      print("登陆数据：" + response.data);
      Map<String, dynamic> json = jsonDecode(response.data);
      callBack(LoginBackBeanEntity.fromJson(json));
    }).catchError((e) {
      showToast(e.toString());
    });
  }

  ///注册
  void register(
      String username, String pwd, String rePwd, Function callBack) async {
    FormData formData = new FormData.from({
      "username": "$username",
      "password": "$pwd",
      "repassword": "$rePwd",
    });
    await dio.post(Api.REGISTER, data: formData).then((response) {
      print("注册数据：" + response.data);
      Map<String, dynamic> json = jsonDecode(response.data);
      callBack(RegisterBackBeanEntity.fromJson(json));
    }).catchError((e) {
      showToast(e.toString());
    });
  }

  get(url, {data, options, cancelToken}) async {
    print('get请求启动! url：$url ,body: $data');
    Response response;
    try {
      response = await dio.get(
        url,
        cancelToken: cancelToken,
      );
      print('get请求成功!response.data：${response.data}');
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('get请求取消! ' + e.message);
      }
      print('get请求发生错误：$e');
    }
    return response.data;
  }

  post(url, {data, options, cancelToken}) async {
    print('post请求启动! url：$url ,body: $data');
    Response response;
    try {
      response = await dio.post(
        url,
        data: data,
      );
      print('post请求成功!response.data：${response.data}');
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('post请求取消! ' + e.message);
      }
      print('post请求发生错误：$e');
    }
    return response.data;
  }

  httpGet<T>(url, OnHttpListener<T> mOnHttpListener) async {
    Response response;
    try {
      response = await dio.get(
        url,
      );
      print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%：${response.data}');
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('%%%%%%%%%%%%%%%%%%%%%%%cancle ' + e.message);
      }
      print('get请求发生错误：$e');
      onError(mOnHttpListener, e);
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.data);
      onSuccess(mOnHttpListener, json);
    }
  }

  onError(OnHttpListener callBack, Exception e) {
    if (callBack != null) {
      callBack.onHttpError(e);
    }
  }

  onSuccess<T>(OnHttpListener callBack, T data) {
    if (callBack != null) {
      callBack.onHttpFinish(data);
    }
  }

  static void get1(String url, Function callback,
      {Map<String, String> params, Function errorCallback}) async {
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }
    try {
      http.Response res = await http.get(url);

      ///200
      if (callback != null) {
        callback(res.body);
      }
    } catch (exception) {
      if (errorCallback != null) {
        errorCallback(exception);
      }
    }
  }

  static void post1(String url, Function callback,
      {Map<String, String> params, Function errorCallback}) async {
    try {
      http.Response res = await http.post(url, body: params);

      if (callback != null) {
        callback(res.body);
      }
    } catch (e) {
      if (errorCallback != null) {
        errorCallback(e);
      }
    }
  }
}
