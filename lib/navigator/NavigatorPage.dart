import 'package:flutter/material.dart';
import 'package:wanandroid/net/HttpUtils.dart';

import 'nav_data_entity.dart';

class NavigatorPage extends StatefulWidget {
  @override
  _NavigatorPageState createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  NavDataEntity _navDataEntity = NavDataEntity();

  @override
  void initState() {
    super.initState();

    HttpUtils.instance.getNavData((NavDataEntity navDataEntity) {
      if (navDataEntity != null) {
        _navDataEntity = navDataEntity;
        print(_navDataEntity.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("导航"),
      ),
    );
  }
}
