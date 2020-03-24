import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wanandroid/bean/BannerData.dart';
import 'package:wanandroid/bean/home_article_data_entity.dart';
import 'package:wanandroid/net/HttpUtils.dart';
import 'package:wanandroid/utils/ToastUtils.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List<DataListBean> bannerDataList = [];
  int bannerLength = 0;

  List<Datas> entitiyList = new List<Datas>();
  ScrollController controller = ScrollController();
  bool isLoadData = false;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    //请求网络轮播图的数据
    getBannerData();

    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        print("加载更多");
        getArticleListData(currentPage + 1);
      }
    });
    getArticleListData(currentPage);
  }

  getBannerData() {
    HttpUtils.instance.getBannerData((BannerData bannerData) {
      if (bannerData.data.length > 0) {
        setState(() {
          bannerDataList = bannerData.data;
          bannerLength = bannerDataList.length;
        });
      }
    });
  }

  getArticleListData(int page) async {
    HttpUtils.instance.getArticleListData(page,
        (HomeArticleDataEntity homePageArticleDataEntity) {
      print("首页文章列表数据----->>>：" + homePageArticleDataEntity.data.toString());

      if (homePageArticleDataEntity == null) {
        print("-----为空---1111----><>>>>>>>");
      } else {
        print("----不为空---1111----><>>>>>>>");
      }

      setState(() {
        if (page == 0) {
          entitiyList = homePageArticleDataEntity.data.datas;
          print("首页文章列表数据：" + homePageArticleDataEntity.data.datas.toString());
        } else {
          List<Datas> newEntitiyList = homePageArticleDataEntity.data.datas;
          entitiyList.addAll(newEntitiyList);
        }
      });
    });
  }

  Future<Null> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        currentPage = 0;
        entitiyList.clear();
        getArticleListData(currentPage);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: getBannerLayout()
      /*RefreshIndicator(
          displacement: 50,
          color: Colors.redAccent,
          backgroundColor: Colors.blue,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return getHomeItemView(context, entitiyList[index]);
            },
            itemCount: entitiyList.length,
            controller: controller,
          ),
          onRefresh: _handleRefresh)*/
      ,
    ));

//    return ;
  }

  Widget getBannerLayout() {
    return Container(
      height: ScreenUtil().setHeight(
          ScreenUtil.getInstance().height / 4), // 高度 插件 flutter_screenutil
      child: Swiper(
        scrollDirection: Axis.horizontal,
        itemCount: bannerLength,
        autoplay: true,
        //拖拽停止自动播放
        autoplayDisableOnInteraction: false,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(bannerDataList[index].imagePath,
              fit: BoxFit.fill);
        },
        onTap: (index) {
          showToast(bannerDataList[index].title);
        },

        pagination: SwiperPagination(
          // 分页指示器
          alignment: Alignment.bottomCenter, // 位置 Alignment.bottomCenter 底部中间
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 5), // 距离调整
          builder: DotSwiperPaginationBuilder(
              // 指示器构建
              space: ScreenUtil().setWidth(5),
              // 点之间的间隔
              size: ScreenUtil().setWidth(10),
              // 没选中时的大小
              activeSize: ScreenUtil().setWidth(12),
              // 选中时的大小
              color: Colors.black54,
              // 没选中时的颜色
              activeColor: Colors.white),
        ),
        control: new SwiperControl(color: Colors.pink),
        // 两张图片之间的间隔
        scale: 0.95,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
