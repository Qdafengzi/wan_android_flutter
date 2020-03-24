import 'package:shared_preferences/shared_preferences.dart';

class SpUtils {
  static put(String key, String value) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static getS(String key, Function callback) async {
    SharedPreferences.getInstance().then((prefs) {
      callback(prefs.getString(key));
    });
  }

  static putUserName(String userName) {
    put("userName", userName);
  }

  static getUserName(Function callback) {
    getS("userName", callback);
  }

  static putPwd(String pwd) {
    put("pwd", pwd);
  }

  static getPwd(Function callback) {
    getS("pwd", callback);
  }
}
