import 'package:flutter/material.dart';
import 'package:wanandroid/bean/home_article_data_entity.dart';

import 'HomeArticleDetailPage.dart';

Widget getHomeItemView(BuildContext context, Datas itemEntity) {
  print("首页文章列表数据====>：" + itemEntity.toString());

  return Container(
    decoration: BoxDecoration(
      color: Colors.grey[200],
    ),
    margin: EdgeInsets.only(bottom: 14),
    child: GestureDetector(
      child: Card(
        color: Colors.white,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
          child: Column(
            children: <Widget>[
              Text(
                itemEntity.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Text("作者："),
                        Text(itemEntity.author),
                      ],
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Text("时间："),
                        Text(itemEntity.niceDate),
                      ],
                    ),
                    flex: 1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        //跳转详情页
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return HomeArticleDetailPage(
            url: itemEntity.link,
          );
        }));
      },
    ),
  );
}
