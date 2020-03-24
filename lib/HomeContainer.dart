import 'package:flutter/material.dart';

import 'factory/TabWidgetFactory.dart';

class HomeContainer extends StatefulWidget {
  @override
  _HomeContainerState createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer>
    with AutomaticKeepAliveClientMixin {
  int _currentIndex = 0;
  List<String> titles = ["首页", "体系", "公众号", "导航", "我的"];
  String title = "首页";
  var body;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: Colors.blue[300],
          centerTitle: true,

          ///true可以使标题居中
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        preferredSize: Size.fromHeight(40),
      ),

//      appBar: PreferredSize(
//        preferredSize:
//            Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
//        child: SafeArea(
//          top: true,
//          child: Offstage(),
//        ),
//      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.redAccent,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              title: Text(
                titles[0],
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.all_inclusive,
              ),
              title: Text(
                titles[1],
              )),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text(
              titles[2],
            ),
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.navigation,
              ),
              title: Text(
                titles[3],
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              title: Text(
                titles[4],
              )),
        ],
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            title = titles[_currentIndex];
          });
        },
      ),
      floatingActionButton: Container(
        height: 68,
        width: 68,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(34),
          color: Colors.white,
        ),
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              _currentIndex = 2;
              print("hello ");
            });
          },
          child: Icon(Icons.add),
          backgroundColor:
              _currentIndex == 2 ? Colors.redAccent : Colors.black45,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  ///IndexedStack可以保存页面的状态
  void initData() {
    body = IndexedStack(
      children: <Widget>[
        TabWidgetFactory.instance.getHomePage(),
        TabWidgetFactory.instance.getSystemPage(),
        TabWidgetFactory.instance.getWechatPage(),
        TabWidgetFactory.instance.getNavigatorPage(),
        TabWidgetFactory.instance.getMyPage(),
      ],
      index: _currentIndex,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
