import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wanandroid/bean/BannerData.dart';
import 'package:wanandroid/utils/ToastUtils.dart';

Widget getBannerLayout() {
  List<DataListBean> bannerDataList = [];
  int bannerLength = 0;

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
        return Image.network(bannerDataList[index].imagePath, fit: BoxFit.fill);
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
