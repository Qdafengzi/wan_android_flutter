import 'package:flutter/material.dart';
import 'package:wanandroid/net/HttpUtils.dart';
import 'package:wanandroid/system/SystemDataDetailPage.dart';
import 'package:wanandroid/utils/ToastUtils.dart';
import 'package:wanandroid/view/BackBtn.dart';

import 'system_data_data_entity.dart';

class SystemDetailPage extends StatefulWidget {
  int cid;

  SystemDetailPage({this.cid});

  @override
  _SystemDetailPageState createState() => _SystemDetailPageState();
}

class _SystemDetailPageState extends State<SystemDetailPage> {
  SystemDataDataEntity _systemDataDataEntity = SystemDataDataEntity();
  ScrollController controller = ScrollController();
  int currentPage = 0;

  int curPage = 1;
  int pageCount = 1;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        print("加载更多");
        if (curPage < pageCount) {
          getSystemDataData(currentPage + 1, more: true);
        } else {
          showToast("无更多数据");
        }
      }
    });
    getSystemDataData(currentPage);
  }

  getSystemDataData(int page, {bool more = false}) {
    HttpUtils.instance
        .getSystemDataData(page, widget.cid >= 0 ? widget.cid : -1,
            (SystemDataDataEntity sSystemDataDataEntity) {
      if (sSystemDataDataEntity != null) {
        setState(() {
          if (more) {
            if (sSystemDataDataEntity.data != null &&
                sSystemDataDataEntity.data.datas != null &&
                sSystemDataDataEntity.data.datas.length > 0) {
              _systemDataDataEntity.data.datas
                  .addAll(sSystemDataDataEntity.data.datas);
            }
          } else {
            _systemDataDataEntity = sSystemDataDataEntity;
          }

          if (_systemDataDataEntity.data != null &&
              _systemDataDataEntity.data.curPage > 0) {
            curPage = _systemDataDataEntity.data.curPage;
          }

          if (_systemDataDataEntity.data != null &&
              _systemDataDataEntity.data.pageCount > 0) {
            pageCount = _systemDataDataEntity.data.pageCount;
          }
        });
      }
    });
  }

  Future<Null> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        currentPage = 0;
        _systemDataDataEntity = null;
        getSystemDataData(currentPage);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("体系二级页面"),
        leading: BackBtn(),
      ),
      body: RefreshIndicator(
          displacement: 50,
          color: Colors.redAccent,
          backgroundColor: Colors.blue,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return getItem(context, _systemDataDataEntity.data.datas[index]);
            },
            itemCount: _getItemCount(),
            controller: controller,
          ),
          onRefresh: _handleRefresh),
    );
  }

  int _getItemCount() {
    if (_systemDataDataEntity == null ||
        _systemDataDataEntity.data == null ||
        _systemDataDataEntity.data.datas == null ||
        _systemDataDataEntity.data.datas.length <= 0) {
      return 0;
    }
    return _systemDataDataEntity.data.datas.length;
  }

  Widget getItem(BuildContext context, SystemDataDataDataData data) {
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
                  data.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
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
                          Text(
                            data.author,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Text("时间："),
                          Text(data.niceDate),
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
            return SystemDataDetailPage(
              url: data.link,
            );
          }));
        },
      ),
    );
  }
}
