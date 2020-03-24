import 'package:flutter/material.dart';
import 'package:wanandroid/Wechat/WechatPage.dart';
import 'package:wanandroid/home/HomePage.dart';
import 'package:wanandroid/my/MyPage.dart';
import 'package:wanandroid/navigator/NavigatorPage.dart';
import 'package:wanandroid/system/SystemPage.dart';

class TabWidgetFactory {
  HomePage mHomePage;
  SystemPage mSystemPage;
  NavigatorPage mNavigatorPage;
  MyPage mMyPage;
  WechatPage mWechatPage;

  // 工厂模式
  factory TabWidgetFactory() => _getInstance();

  static TabWidgetFactory get instance => _getInstance();
  static TabWidgetFactory _instance;

  TabWidgetFactory._internal() {
    // 初始化
  }

  static TabWidgetFactory _getInstance() {
    if (_instance == null) {
      _instance = TabWidgetFactory._internal();
    }
    return _instance;
  }

  Widget getHomePage() {
    if (mHomePage == null) {
      mHomePage = HomePage();
    }
    return mHomePage;
  }

  Widget getSystemPage() {
    if (mSystemPage == null) {
      mSystemPage = SystemPage();
    }
    return mSystemPage;
  }

  Widget getNavigatorPage() {
    if (mNavigatorPage == null) {
      mNavigatorPage = NavigatorPage();
    }
    return mNavigatorPage;
  }

  Widget getMyPage() {
    if (mMyPage == null) {
      mMyPage = MyPage();
    }
    return mMyPage;
  }

  Widget getWechatPage() {
    if (mWechatPage == null) {
      mWechatPage = WechatPage();
    }
    return mWechatPage;
  }
}
