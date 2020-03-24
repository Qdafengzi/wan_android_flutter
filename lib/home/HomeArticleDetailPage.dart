import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wanandroid/view/BackBtn.dart';

class HomeArticleDetailPage extends StatefulWidget {
  String url;
  HomeArticleDetailPage({this.url});

  @override
  _HomeArticleDetailPageState createState() => _HomeArticleDetailPageState();

  String getUrl() {
    print("-----------------------" + url);
    return url;
  }
}

class _HomeArticleDetailPageState extends State<HomeArticleDetailPage> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.getUrl(),
      appBar: AppBar(
        title: Text("详情"),
        leading: BackBtn(),
      ),
    );
  }
}
