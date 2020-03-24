import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wanandroid/view/BackBtn.dart';

class SystemDataDetailPage extends StatefulWidget {
  String url;
  SystemDataDetailPage({this.url});

  @override
  _SystemDataDetailPageState createState() => _SystemDataDetailPageState();

  String getUrl() {
    print("-----------------------" + url);
    return url;
  }
}

class _SystemDataDetailPageState extends State<SystemDataDetailPage> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.getUrl(),
      appBar: AppBar(
        title: Text("体系详情"),
        leading: BackBtn(),
      ),
    );
  }
}
