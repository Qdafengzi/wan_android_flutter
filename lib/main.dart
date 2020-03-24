import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'SplashPage.dart';

void main() {
  runApp(MaterialApp(
    title: "Wan Android",

    theme: ThemeData(

        ///全局配置字体
//      textTheme:
//          TextTheme(body1: TextStyle(fontFamily: 'ZCOOL+QingKe+HuangYou')),
//      primaryIconTheme: const IconThemeData(color: Colors.white),
        ),
//        brightness: Brightness.light,
//        primaryColor: Colors.green,
//        accentColor: Colors.red),
    debugShowCheckedModeBanner: false,
    home: SplashPage(),
  ));
  //黑色状态栏字体
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
}
