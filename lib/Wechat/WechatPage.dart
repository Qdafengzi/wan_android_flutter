import 'package:flutter/material.dart';
import 'package:wanandroid/home/HomePageArticleList.dart';

class WechatPage extends StatefulWidget {
  @override
  _WechatPageState createState() => _WechatPageState();
}

class _WechatPageState extends State<WechatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePageArticleList(),
    );
  }
}
