//import 'dart:convert';
//
//import 'package:flutter/material.dart';
//import 'package:wan_android/bean/home_page_article_data_entity.dart';
//import 'package:wan_android/home/HomeItemWidget.dart';
//import 'package:wan_android/net/HttpUtils.dart';
//
//Widget getHomeListWidget(BuildContext context, int current_Page) {
//  List<HomePageArticleDataDataData> entitiyList = [];
//  ScrollController controller = ScrollController();
//  int currentPage = current_Page;
//
//  controller.addListener(() {
//    if (controller.position.pixels == controller.position.maxScrollExtent) {
//      print("加载更多");
//      getArticleListData(currentPage + 1);
//    }
//  });
//  getArticleListData(currentPage);
//
//  getArticleListData(int page) async {
//    var jsonStr = await HttpUtils.instance
//        .get("article/list/+" + page.toString() + "/json");
//    Map<String, dynamic> json = jsonDecode(jsonStr);
//    HomePageArticleDataEntity homePageArticleDataEntity =
//        HomePageArticleDataEntity.fromJson(json);
//
//    setState(() {
//      if (page == 0) {
//        entitiyList = homePageArticleDataEntity.data.datas;
//      } else {
//        List<HomePageArticleDataDataData> newEntitiyList =
//            homePageArticleDataEntity.data.datas;
//        entitiyList.addAll(newEntitiyList);
//      }
//    });
//  }
//
//  Future<Null> _handleRefresh() async {
//    await Future.delayed(Duration(seconds: 2), () {
//      setState(() {
//        currentPage = 0;
//        entitiyList.clear();
//        getArticleListData(currentPage);
//      });
//    });
//  }
//
//  return RefreshIndicator(
//      displacement: 50,
//      color: Colors.redAccent,
//      backgroundColor: Colors.blue,
//      child: ListView.builder(
//        itemBuilder: (BuildContext context, int index) {
//          return getHomeItemView(entitiyList[index]);
//        },
//        itemCount: entitiyList.length + 1,
//        controller: controller,
//      ),
//      onRefresh: _handleRefresh);
//}
