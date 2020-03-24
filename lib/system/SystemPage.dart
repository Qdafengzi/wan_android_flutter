import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wanandroid/net/HttpUtils.dart';
import 'package:wanandroid/system/SystemDetailPage.dart';

import 'system_data_entity.dart';

class SystemPage extends StatefulWidget {
  @override
  _SystemPageState createState() => _SystemPageState();
}

class _SystemPageState extends State<SystemPage>
    with AutomaticKeepAliveClientMixin {
  SystemDataEntity _systemDataEntity = SystemDataEntity();

  @override
  void initState() {
    super.initState();
    HttpUtils.instance.getSystemData((SystemDataEntity sytemDataEntity) {
      setState(() {
        if (_systemDataEntity != null) {
          _systemDataEntity = sytemDataEntity;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      //安卓效果
      //physics: ClampingScrollPhysics(),
      //ios效果
      physics: BouncingScrollPhysics(),
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        spacing: 2,
        runSpacing: 5,
        children: Boxs(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  //TODO:长度为空
  List<Widget> Boxs() => List.generate(_systemDataEntity.data.length, (index) {
        return SystemButton(_systemDataEntity.data[index]);
      });
}

class SystemButton extends StatelessWidget {
  SytemDataData sytemDataData;

  SystemButton(this.sytemDataData);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      disabledColor: Colors.grey,
      color: getRandomColor(),
      textColor: Colors.black,
      disabledTextColor: Colors.black54,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: getRandomColor()),
        borderRadius: BorderRadius.circular(8),
      ),
      onPressed: () {
        if (sytemDataData.children.length > 0) {
          var children = sytemDataData.children;
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return SystemTabPage(children, sytemDataData.name);
          }));

          //本来的下面弹窗去除
          /*showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Stack(
                  children: <Widget>[
                    Container(
                      height: 22,
                      width: double.infinity,
                      color: Colors.black54,
                    ),
                    Container(
                      height: 200,
                      padding: EdgeInsets.only(top: 8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          )),
                      child: ListView.separated(
                        padding: EdgeInsets.all(8.0),
                        separatorBuilder: (context, index) {
                          return Container(
                            height: 1,
                            color: Colors.grey,
                          );
                        },
                        itemCount: sytemDataData.children.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Item(sytemDataData.children[index].name,
                              sytemDataData.children[index].id);
                        },
                      ),
                    )
                  ],
                );
              });*/
        }
      },
      child: Text(this.sytemDataData.name),
    );
  }

  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(random.nextInt(255), random.nextInt(255),
        random.nextInt(255), random.nextInt(255));
  }
}

class Item extends StatelessWidget {
  String name;
  int id;

  Item(this.name, this.id);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
            child: Text(
              this.name,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          onTap: () {
            Navigator.pop(context);

            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return null;
            }));

//            Navigator.of(context)
//                .push(MaterialPageRoute(builder: (BuildContext context) {
//              return SystemDetailPage(
//                cid: id,
//              );
//            }));
          },
        ),
      ),
    );
  }
}
