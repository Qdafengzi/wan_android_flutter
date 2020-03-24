import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'HomeContainer.dart';
import 'net/HttpUtils.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = new Timer(const Duration(milliseconds: 2000), () {
      try {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => HomeContainer()),
            (Route route) => route == null);
      } catch (e) {}
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //填入设计稿中设备的屏幕尺寸
    //默认 width : 1080px , height:1920px , allowFontScaling:false
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    //假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 1920)..init(context);
    //设置字体大小根据系统的“字体大小”辅助选项来进行缩放,默认为false
//    ScreenUtil.instance = ScreenUtil(width: 1080, height: 1920, allowFontScaling: false)..init(context);
    HttpUtils.instance;

    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Image.asset(
          "images/logo.png",
          scale: 2,
        ),
      ),
    );
  }
}
