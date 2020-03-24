import 'package:wanandroid/system/system_data_data_entity.dart';
import 'package:wanandroid/system/system_data_entity.dart';

import 'bean/home_article_data_entity.dart';
import 'my/login_back_bean_entity.dart';
import 'my/register_back_bean_entity.dart';
import 'navigator/nav_data_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "HomePageArticleDataEntity") {
      return HomeArticleDataEntity.fromJson(json) as T;
    } else if (T.toString() == "SystemDataDataEntity") {
      return SystemDataDataEntity.fromJson(json) as T;
    } else if (T.toString() == "SystemDataEntity") {
      return SystemDataEntity.fromJson(json) as T;
    } else if (T.toString() == "RegisterBackBeanEntity") {
      return RegisterBackBeanEntity.fromJson(json) as T;
    } else if (T.toString() == "LoginBackBeanEntity") {
      return LoginBackBeanEntity.fromJson(json) as T;
    } else if (T.toString() == "NavDataEntity") {
      return NavDataEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}
